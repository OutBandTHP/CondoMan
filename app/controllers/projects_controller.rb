class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new(since: Date.today.to_s)
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "#{@project.name} was successfully created."
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @project = Project.find params[:id]
  end
  
  def update
    @project = Project.find params[:id]
    @project.update_attributes!(project_params)
    flash[:notice] = "#{@project.name} was successfully updated."
    redirect_to root_path
  end
  
  def destroy
    
  end

  private
    def project_params
      params.require(:project).permit(:name, :admin, :address, :email, :since)
    end
end
