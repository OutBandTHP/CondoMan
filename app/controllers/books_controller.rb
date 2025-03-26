class BooksController < ApplicationController
  before_action :set_project

  def index
    @books = Book.where(project_id: @project.id)
    store_location
  end

  def edit
    @groups = Book.where(project_id: @project.id)
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "הספר #{@book.name} עודכן בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  def new
    @groups = Book.where(project_id: @project.id)
    @book = Book.new
    @book.project_id = @project.id
  end

  def create
    @book = Book.new(book_params)
    @book.project_id = @project.id
    if @book.save
      flash[:success] = "הספר #{@book.name} נוצר בהצלחה"
      redirect_back_or root_path
    else
      render 'new'
    end
  end


  private

    def book_params
      params.require(:book).permit(:name, :kind, :group_id, :project_id)
    end
    
    def set_project
      @project = Project.find(session[:project_id])
    end
end
