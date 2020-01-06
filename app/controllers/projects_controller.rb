class ProjectsController < ApplicationController
  DefPW = "123456"
  
  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new(since: Date.today.to_s)
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      if admin_user = User.find_by(email: @project.admin)
        admin_user.authority = User.admin
        admin_user.save
      else
        admin_user = User.new(email:     @project.admin,
                              authority: User.admin,
                              password:  DefPW, 
                              password_confirmation: DefPW)
        if admin_user.save
          admin_user.send_activation_email
        end
      end
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
    store_location
  end
  
  def update
    @project = Project.find params[:id]
    @project.update_attributes!(project_params)
    flash[:success] = "#{@project.name} was successfully updated."
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
