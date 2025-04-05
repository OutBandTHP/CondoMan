class SelectProjectController < ApplicationController
  skip_before_action :set_current_project

  def edit
    session[:project_id] = params[:id]
    unless session[:project_id].nil?
      @project = Project.find(session[:project_id])
      flash[:success] = "הפרוייקט '#{@project.name}' נבחר"
    else
      flash[:danger] = "בחירת פרויקט לא תקינה"
    end
    redirect_to root_url
  end  
end
