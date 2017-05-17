class PagesController < ApplicationController
  
  def home
    redirect_to scenes_path if logged_in?
  end
  
  def dashboard
  end
  
end