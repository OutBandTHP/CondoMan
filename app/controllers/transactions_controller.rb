class TransactionsController < ApplicationController
  def index
    @transactions = @project.transactions.where(finyear: @year.finyear)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def eomverify
    @month = @project.current_month
    render 'eom'
  end
  
  def eomexec
    ok = true
    Transaction.transaction do
      @project.set_month
      desc = "חיוב חודשי עבור #{@project.current_month.year}/#{@project.current_month.month}"
      fin = @year.finyear.to_s + "/"
      prj = @project.id
      trx = @project.get_value(:tx_monthly).to_i
      dt = Date.today
      @project.units.each do |u| 
        rf = fin+@project.set_reference
        tot = @year.ppm * u.area
        trid = Transaction.create!(project_id: prj, finyear: @year.finyear, trdate: dt, 
                                   trans_type_id: trx, book_id: @project.get_value(:gl_tenants), 
                                   unit_id: u.id, description: desc, refin: rf, sum: tot)
        if trid.nil? 
          ok = false
          raise ActiveRecord::Rollback
        end
        DeployBook.get_deployment(prj, trx). each do |db|
          if db[0] > 0
            gl = db[0]
            db = 1
            cr = 0
          else
            gl = db[1]
            db = 0
            cr = 1
          end  
          glid = Ledger.create!(project_id: prj, finyear: @year.finyear, trdate: dt, trans_type_id: trx, transaction_id: trid.id, book_id: gl, 
                                unit_id: u.id, description: desc, refin: rf, debit: tot * db, credit: tot * cr)
          if glid.nil? 
            ok = false
            raise ActiveRecord::Rollback
          end
        end
      end
    end
    if ok
      flash[:success] = "סוף/תחילת חודש בוצע בהצלחה"
    end
    redirect_to root_path
  end
end
