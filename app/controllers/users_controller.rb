class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :destroy, :index, :show, :update]
  before_action :correct_user,   only: [:edit, :show, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    if logged_in? && current_user.is_tenant?
      flash[:warning] = "You are not authorized for this action"
      redirect_to(root_url)
    else
      @user = User.new(authority: User.tenant)
    end
  end

  def create
    @user = User.new(user_params)
    @user.authority = User.tenant
    if @user.save
      log_in @user
      flash[:success] = "Welcome to CondoMan - you\'re Logged in as #{@user.name}"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      flash[:success] = "#{@user.name} was successfully updated."
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      if current_user?(@user) || current_user.manages?(@user.authority)
      else
        flash[:warning] = "You are not authorized for this action"
        redirect_to(root_url)
      end
    end
    
    def admin_user
      redirect_to(root_url) if current_user.is_tenant?
    end    
end