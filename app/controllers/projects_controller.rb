class ProjectsController < ApplicationController
  def project_params
    params.require(:project).permit(:name, :admin, :address, :email, :since)
  end

  def new 
  end
  
  def create
    @project = Project.create!(project_params)
    flash[:notice] = "#{@project.name} was successfully created."
    redirect_to admin_path
  end
  
  def edit
    @project = Project.find params[:id]
  end
  
  def update
    @project = Project.find params[:id]
    @project.update_attributes!(project_params)
    flash[:notice] = "#{@project.name} was successfully updated."
    redirect_to admin_path
  end
  
  def destroy
    
  end
end
