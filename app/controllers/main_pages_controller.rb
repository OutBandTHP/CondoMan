class MainPagesController < ApplicationController
  skip_before_action :logged_in_user
  skip_before_action :set_current_project

  def home
  end

  def help
  end

  def about
  end
end
