module ApplicationHelper

  def full_title(page_title = '')
    base_title = "CondoMan App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def project_set?
    if logged_in? and @current_user.is_admin?
      session[:project_id] ||= Project.find_by(admin: @current_user.email).id
    end
    unless session[:project_id].nil?
      @project = Project.find(session[:project_id])
    end
    !session[:project_id].nil?
  end
end