class NotificationsController < ApplicationController
  skip_before_action :set_current_project
  
  def index
    @projects = Project.all
    @notifications = Notification.all
    store_location
  end

  def new
    @projects = Project.all
    @notification = Notification.new
  end

  def show
    @notification = Notification.find(params[:id])
    if @notification.project_id.nil?
      @project = nil
    else
      @project = Project.find(@notification.project_id)
    end
  end

  def edit
    @notification = Notification.find(params[:id])
    @projects = Project.all
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_back_or root_path
    else
      render 'new'
    end
  end

  def update
    @notification = Notification.find(params[:id])
    if @notification.update(notification_params)
      flash[:success] = "הודעה #{@notification.id} עודכנה בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  private
    def notification_params
      params.require(:notification).permit(:text_message, :valid_from, :valid_to, :project_id)
    end
end
