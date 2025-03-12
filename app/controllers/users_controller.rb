class UsersController < ApplicationController
  include ApplicationHelper
  
  before_action :logged_in_user, only: [:edit, :destroy, :index, :show, :update]
  before_action :correct_user,   only: [:edit, :show, :update]
  before_action :check_admin,    only: :destroy
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @user = User.find(params[:id]) 
  end
  
  def new
    if logged_in? && is_tenant?
      flash[:warning] = "You are not authorized for this action"
      redirect_to(root_url)
    else
      @user = User.new
      @role = Role.new
    end
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        puts "----> going to create role for user: #{@user.email}"
        role_params
        flash[:info] = create_user_role(params[:project], @user, params[:level], params[:unit])
        puts "----> created with message: #{flash[:info]}"
        redirect_to root_url
      else
        render 'new'
      end
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
    
    def role_params
      params.require(:role).permit(:project, :unit, :level)
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
      if current_user?(@user) || current_user.manages?(current_user_role(@user))
      else
        flash[:warning] = "You are not authorized for this action"
        redirect_to(root_url)
      end
    end
    
    def check_admin
      redirect_to(root_url) if is_tenant? || is_owner?
    end    
end