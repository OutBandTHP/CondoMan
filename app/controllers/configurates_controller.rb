class ConfiguratesController < ApplicationController
  include ApplicationHelper

  before_action :project_set?

  def edit
    @configurate = Project.find params[:id]
  end
  
  def update
      @configurate = Project.find params[:id]
      if @configurate.update(configurate_params)
        flash[:success] = 'אפיון הפרוייקט בוצע בהצלחה'
        redirect_to root_path
      else
        render 'edit'
      end
  end

  private
    def configurate_params
      params.require(:project).permit(:name, :current_month, :total_area,
                                      :gl_tenants, :gl_suppliers, :gl_expenses, :gl_income, :gl_budget, 
                                      :tx_monthly, :tx_expense, :tx_income, :tx_support, 
                                      :gr_cash_flow, :gr_pos_side, :gr_neg_side, :gr_open_balance, :gr_for_balance, :gr_for_flow)
    end
end
