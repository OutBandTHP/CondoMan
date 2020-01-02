module ProjectsHelper

  def project_set?
    if logged_in?
      session[:project_id] ||= Project.find_by(admin: @current_user.email)
    end
    unless session[:project_id].nil?
      @project = Project.find(session[:project_id])
    end
  end
end
