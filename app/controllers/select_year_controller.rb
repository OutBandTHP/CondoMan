class SelectYearController < ApplicationController
  def edit
    session[:year_id] = params[:id]
    unless session[:year_id].nil?
      @year = Year.find(params[:id])
      flash[:success] = "'#{@year.finyear}'נבחרה "
    else
      flash[:danger] = "בחירת שנה לא תקינה"
    end
    redirect_to root_url
  end
end
