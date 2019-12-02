class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new(authority: User.user_types.fetch(:Tenant))
  end

  def create
    @user = @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to CondoMan - you\'re Logged in as #{@user.name}"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]
    @user.update_attributes(user_params)
    if @user.save
      log_in @user
      flash[:success] = "#{@user.name} was successfully updated."
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :authority, :password, :password_confirmation)
    end
end