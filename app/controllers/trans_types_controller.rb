class TransTypesController < ApplicationController
  skip_before_action :set_current_project
  
  def index
    @trans_types = TransType.all
    store_location
  end

  def show
    @trans_type = TransType.find(params[:id])
  end

  def edit
    @trans_type = TransType.find(params[:id])
  end

  def update
    @trans_type = TransType.find(params[:id])
    if @trans_type.update(trans_type_params)
      flash[:success] = "סוג תנועה #{@trans_type.code} עודכנה בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  def new
    @trans_type = TransType.new
  end

  def create
    @trans_type = TransType.new(trans_type_params)
    if @trans_type.save
      flash[:success] = "סוג תנועה #{@trans_type.code} נוצר בהצלחה"
      redirect_back_or root_path
    else
      render 'new'
    end
  end

  private
    def trans_type_params
      params.require(:trans_type).permit(:code, :name)
    end
end
