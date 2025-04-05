class YearsController < ApplicationController
    
  def index
    @years = @project.years
    store_location
  end
  
  def edit
    @year = Year.find(params[:id])
  end
  
  def update
    @year = Year.find(params[:id])
    if @year.update(year_params)
      flash[:success] = "שנת התקציב '#{@year.finyear}' עודכנה בהצלחה"
      redirect_back_or root_path
    else
      render 'edit'
    end
  end

  private
    def year_params
      params.require(:year).permit(:finyear, :ppm)
    end
  
end
