class AddCurrentMonthToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :current_month,   :date
    add_column :projects, :total_area,      :decimal
    add_column :projects, :gl_tenants,      :integer
    add_column :projects, :gl_suppliers,    :integer
    add_column :projects, :gl_expenses,     :integer
    add_column :projects, :gl_income,       :integer
    add_column :projects, :gl_budget,       :integer
    add_column :projects, :tx_monthly,      :string
    add_column :projects, :tx_expense,      :string
    add_column :projects, :tx_income,       :string
    add_column :projects, :tx_support,      :string
    add_column :projects, :gr_cash_flow,    :string
    add_column :projects, :gr_pos_side,     :string
    add_column :projects, :gr_neg_side,     :string
    add_column :projects, :gr_open_balance, :string
    add_column :projects, :gr_for_balance,  :string
    add_column :projects, :gr_for_flow,     :string
  end
end
