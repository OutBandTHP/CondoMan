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
      Range.new(1, @project.no_buildings).each do |num| 
        Building.create(id_code: num, project_id: @project.id)
      end
      Range.new(1, @project.no_units).each do |num| 
        Unit.create(number: num, since: @project.since, project_id: @project.id)
      end
      set_project @project
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

  private
    def project_params
      params.require(:project).permit(:name, :admin, :address, :email, :since, :no_buildings, :no_units)
    end
    
    def set_project(project)
      session[:project_id] = project.id
    end

end
