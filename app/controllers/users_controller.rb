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
      flash[:success] = "Welcome to CondoMan - you're welcome to Log in"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :authority, :password, :password_confirmation)
    end
end