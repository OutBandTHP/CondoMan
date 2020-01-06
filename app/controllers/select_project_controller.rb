class SelectProjectController < ApplicationController
  def edit
    session[:project_id] = params[:id]
    unless session[:project_id].nil?
      @project = Project.find(session[:project_id])
      flash[:success] = "Project #{@project.name} was selecetd"
    else
      flash[:danger] = "Invalid project selected"
    end
    redirect_to root_url
  end  
end
