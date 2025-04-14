class SessionsController < ApplicationController
  skip_before_action :logged_in_user
  skip_before_action :set_current_project
  
  def new
  end
    
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user  # MH was back_or
      else
        message  = "החשבון טרם הופעל. "
        message += "מצא בחשבון המייל שלך אחר הוראות הפעלה"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'הצירוף מייך/סיסמא לא מוכר'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
