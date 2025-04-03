class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :logged_in_user
  
  Default_Password = "123456"
  
  def show
    @project = Project.find(params[:id])
    @buildings = @project.buildings
    @units = @project.units
  end

  def new
    @project = Project.new(since: Date.today.to_s)
  end
  
  def create
    ActiveRecord::Base.transaction do
      @project = Project.new(project_params)
      if @project.save
        message = define_admin_user
        Range.new(1, @project.no_buildings).each do |num| 
          @nbuild = Building.create(id_code: num, project_id: @project.id)
        end
        Range.new(1, @project.no_units).each do |num| 
          @n_unit = Unit.create(number: num, since: @project.since, project_id: @project.id, building: @nbuild.id, area: 50)
          @n_user = User.create(name: "בעלים ליחידה-#{num.to_s}", email: "user_u#{num}_p#{@project.id}@gmail.com", 
                               password: Default_Password, password_confirmation: Default_Password)
          @n_role = Role.create(authority: Role.Owner, project_id: @project.id, unit_id: @n_unit.id, user_id: @n_user.id, since: @project.since)
        end
        set_project(@project) 
        flash[:success] = "'#{@project.name}' נוצר בהצלחה" + message
        redirect_to root_path
      else
        render 'new'
      end
    end
  end
  
  def edit
    @project = Project.find params[:id]
    @buildings = @project.buildings
    @unis = @project.units
    store_location
  end
  
  def update
    ActiveRecord::Base.transaction do
      @project = Project.find params[:id]
      if @project.update(project_params)
        message = define_admin_user
        flash[:success] = "'#{@project.name}' עודכן בהצלחה #{message}"
        redirect_to root_path
      else
        render 'edit'
      end
    end
  end

  private
    def define_admin_user
      message = ""
      admin_user = User.find_by(email: @project.admin)
      unless admin_user
        admin_user = User.new(email:     @project.admin,
                              password:  Default_Password, 
                              password_confirmation: Default_Password)
        if admin_user.save
          admin_user.send_activation_email
        end
        message = "'#{admin_user.email}' חייב להפעיל את חשבון המייל שלו - זהו חשבון מייל חדש!!!"
      end
#      create_user_role(@project, admin_user, Role.admin)
      return message
    end
    
    def project_params
      params.require(:project).permit(:name, :admin, :address, :email, :since, :no_buildings, :no_units)
    end

end
