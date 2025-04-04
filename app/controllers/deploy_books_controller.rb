class DeployBooksController < ApplicationController
  before_action :set_project

  def index
    @deploy_books = DeployBook.where(project_id: @project.id)
    @books = Book.where(project_id: @project.id).order('name ASC')
    @trans_types = TransType.all
    store_location
  end

  def edit
    @books = Book.where(project_id: @project.id).order('name ASC')
    @trans_types = TransType.all
    @deploy_book = DeployBook.find(params[:id])
  end

  def update
    @books = Book.where(project_id: @project.id).order('name ASC')
    @deploy_book = DeployBook.find(params[:id])
    if @deploy_book.update(deploy_params)
      flash[:success] = "פריסת התנועה עודכנה בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  def new
    @books = Book.where(project_id: @project.id).order('name ASC')
    @trans_types = TransType.all
    @deploy_book = DeployBook.new
    @deploy_book.project_id = @project.id
  end

  def create
    @books = Book.where(project_id: @project.id).order('name ASC')
    @trans_types = TransType.all
    @deploy_book = DeployBook.new(deploy_params)
    @deploy_book.project_id = @project.id
    if @deploy_book.save
      flash[:success] = "פריסת התנועה נוצרה בהצלחה"
      redirect_back_or root_path
    else
      render 'new'
    end
  end


  private

    def deploy_params
      params.require(:deploy_book).permit(:project_id, :trans_type_id, :book_neg_id, :book_pos_id)
    end
    
    def set_project
      @project = Project.find(session[:project_id])
    end
end
