class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery
  before_action :set_locale
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def set_locale
    I18n.locale = 'he'
  end
  
  
    private
    
    def record_not_found
      render :text => "404 Not Found", :status => 404
    end
end
