class ProjectsController < ApplicationController
  include ApplicationHelper

  Default_Password = "123456"
  
  def show
    @project = Project.find(params[:id])
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
          Building.create(id_code: num, project_id: @project.id)
        end
        Range.new(1, @project.no_units).each do |num| 
          Unit.create(number: num, since: @project.since, project_id: @project.id)
        end
        set_project(@project) 
        flash[:success] = "#{@project.name} was successfully created. " + message
        redirect_to root_path
      else
        render 'new'
      end
    end
  end
  
  def edit
    @project = Project.find params[:id]
    store_location
  end
  
  def update
    ActiveRecord::Base.transaction do
      @project = Project.find params[:id]
      if @project.update_attributes(project_params)
        message = define_admin_user
        flash[:success] = "#{@project.name} was successfully updated. #{message}"
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
        message = "#{admin_user.email} must activate its account (it is a new user) !!!"
      end
      create_user_role(@project, admin_user, Role.admin)
      return message
    end

    def project_params
      params.require(:project).permit(:name, :admin, :address, :email, :since, :no_buildings, :no_units)
    end

end
