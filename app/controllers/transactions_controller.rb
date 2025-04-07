class TransactionsController < ApplicationController
  def index
    @transactions = @project.transactions.find_by(finyear: @year)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end
end
