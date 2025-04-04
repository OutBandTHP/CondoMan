class UnitsController < ApplicationController
    
  def index
    @project = Project.find(session[:project_id])
    @units = @project.units
    @roles = @project.roles
    store_location
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update(unit_params)
      flash[:success] = "דירה #{@unit.number} עודכנה בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  private
    def unit_params
      params.require(:unit).permit(:building, :floor, :area, :since, :payer)
    end
end
