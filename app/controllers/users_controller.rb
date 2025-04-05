class UsersController < ApplicationController
  include ApplicationHelper
  skip_before_action :logged_in_user
  skip_before_action :set_current_project

  before_action      :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action      :correct_user,   only: [:edit, :show, :update]
  before_action      :admin_user,     only: [:destroy]
  
  def index
    if project_set? && !at_admin_level?
      @project = Project.find(session[:project_id])
      @users = User.select(:user_id)                        #.paginate(page: params[:page], per_page: 10)
    else
      @users = User.all                                      #.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def show
    @user = User.find(params[:id]) 
    if is_sysadmin? 
      @role = Role.find_by(user_id: @user.id)
    else
      if project_set?
        @project = Project.find(session[:project_id])
        @role = @project.roles.find_by(user_id: @user.id)
      end
    end
  end
  
  def new
    if logged_in? && !at_admin_level?
      flash[:warning] = "אינך מוסמך לבצע פעולה זו log:#{logged_in?} aut:#{is_Tenant?}"
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
        role_params
        flash[:info] = create_user_role(params[:project], @user, params[:level], params[:unit])
        redirect_to root_url
      else
        render 'new'
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if is_sysadmin? 
      @role = Role.find_by(user_id: @user.id)
    else
      @project = Project.find(session[:project_id])
      if @project.nil? 
        @project =  @user.roles.first.project_id
      end
      @role = @project.roles.find_by(user_id: @user.id)
    end
  end
  
  def update
    @user = User.find params[:id]
    if @user.update(user_params)
#      @user.send_activation_email if !@user.activated 
      flash[:success] = "משתמש '#{@user.name}' עודכן בהצלחה"
      redirect_to root_url
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
    
    def correct_user
      @user = User.find(params[:id])
      if current_user?(@user) || current_user.manages?(current_user_role(@user), @project)
      else
        flash[:warning] = "אינך מוסמך לבצע פעולה זו"
        redirect_to(root_url)
      end
    end
    
    def admin_user
      redirect_to(root_url) if is_tenant?
    end    
end