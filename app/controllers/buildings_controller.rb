class BuildingsController < ApplicationController
  def show
    @building = Building.find(params[:id])
    @project = @building.project
  end

  def edit
    @building = Building.find(params[:id])
    @project = @building.project
  end
  
  def update
    @building = Building.find(params[:id])
    @project = @building.project
    @building.update_attributes!(building_params)
    flash[:notice] = "#{@building.id_code} was successfully updated."
    redirect_to root_path
  end

  private
    def building_params
      params.require(:building).permit(:id_code, :address)
    end
end
