class SuppliersController < ApplicationController
    
  def index
    @suppliers = Supplier.where(project_id: @project.id)
    store_location
  end
  
  def show
    @supplier = Supplier.find(params[:id])
  end
  
  def new
    @supplier = Supplier.new
    @books = Book.where(project_id: @project.id).order('name ASC')
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @books = Book.where(project_id: @project.id).order('name ASC')
    @supplier.project_id = @project.id
    if @supplier.save
      flash[:success] = "ספק '#{@supplier.name}' נוצר בהצלחה"
      redirect_back_or root_path
    else
      render 'new'
    end
  end
  
  def edit
    @supplier = Supplier.find(params[:id])
    @books = Book.where(project_id: @project.id).order('name ASC')
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    @books = Book.where(project_id: @project.id).order('name ASC')
    if @supplier.update(supplier_params)
      flash[:success] = "ספק '#{@supplier.name}' עודכן בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  private
    def supplier_params
      params.require(:supplier).permit(:project_id, :name, :contact, :email, :phone, :book_id)
    end
end
