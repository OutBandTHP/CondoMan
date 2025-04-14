class TransactionsController < ApplicationController
  def index
    @transactions = @project.transactions.where(finyear: @year.finyear)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def new
    tr = params[:format]
    @transaction = Transaction.new
    @units = @project.units
    if tr.nil?
      flash[:warning] = "אינך מוסמך לבצע פעולה זו"
      redirect_to(root_url)
    else
      @refin = @year.finyear.to_s + "/" + @project.set_reference
      @prevs = @project.transactions.where("finyear =  #{@year.finyear} AND trans_type_id < #{tr.gsub('tx','')} AND trclosed = false").all
    end
    render tr
  end

  def create
    tr = params[:trans_type_id]
    if tr.nil?
      flash[:warning] = "אינך מוסמך לבצע פעולה זו"
      redirect_to(root_url)
      exit sub
    end
    prev = params[:transactions_id]
    @transaction = Transaction.new(tx_params)
    @transaction.project_id = @project.id
    @transaction.trans_type_id = tr
    if !prev.nil?
      @transaction.finyear = Transaction.find(prev).finyear
      @transaction.refin = Transaction.find(prev).refin
      @transaction.transactions_id = Transaction.find(prev).id
    else
      @transaction.finyear = @year.finyear
    end
    debugger
    if @transaction.save
      flash[:success] = "רשום התנועה נוצר בהצלחה"
      redirect_back_or root_path
    else
      @units = @project.units
      @refin = @year.finyear.to_s + "/" + @project.set_reference
      @prevs = @project.transactions.where(finyear: @year.finyear, trclosed: false)
      render "tx" + sprintf("%02d", tr)
    end
    redirect_to(root_url)
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
        trid = Transaction.create!(project_id: prj, finyear: @year.finyear, trdate: dt, trans_type_id: trx,  
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

  private

    def tx_params
      params.require(:transaction).permit(:project_id, :finyear, :trdate, :trclosed, :trans_type_id, 
                     :supplier_id, :unit_id, :description, :refin, :refex, :remarks, :sum, :transactions_id)
    end
end
