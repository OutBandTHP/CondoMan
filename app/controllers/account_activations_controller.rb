class AccountActivationsController < ApplicationController
  skip_before_action :logged_in_user
  skip_before_action :set_current_project
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated! - please update your details and setup a new password"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end  
end
