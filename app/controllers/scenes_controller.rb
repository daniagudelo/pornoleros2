class ScenesController < ApplicationController
  
  def index
    @scenes = Scene.all
  end
  
  def show
    @scene = Scene.find(params[:id])
  end
  
  def new
    @scene = Scene.new
  end
  
  def create
    @scene = Scene.new(scene_params)
    @scene.user = User.first
    if @scene.save
      flash[:success] = "Scene was created successfully"
      redirect_to scene_path(@scene)
    else
      render 'new'
    end
  end
  
  private
  
  def scene_params
    params.require(:scene).permit(:title, :description)
  end
  
end