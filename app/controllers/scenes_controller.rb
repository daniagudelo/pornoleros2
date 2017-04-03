class ScenesController < ApplicationController
  
  def index
    @scenes = Scene.all
  end
end