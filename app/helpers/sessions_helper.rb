module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
    if p_id = session[:project_id]
      @project = Project.find_by[id: p_id]
    elsif user.roles.first.project
      @project = user.roles.first.project
    else
      @project = nil
    end
    set_project(@project) if @project
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent[:project_id] = session[:project_id]
  end
  
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def current_user?(user)
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    cookies.delete(:project_id)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    session.delete(:project_id)
    @current_user = nil
    @project = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def set_project(project)
    session[:project_id] = project.id
    @project = project
  end
  
end
