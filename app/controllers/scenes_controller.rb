class ScenesController < ApplicationController
  before_action :set_scene, only: [:show, :edit, :update]
  
  def index
    @scenes = Scene.all
  end
  
  def listing
    @scenes = Scene.all
  end
  
  def show
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
  
  def edit
  end
  
  def update
    if @scene.update(scene_params)
      flash[:success] = "Scene was successfully updated!"
      redirect_to scene_path(@scene)
    else
      render 'edit'
    end
  end
  
  def destroy
    @scene = Scene.find(params[:id]).destroy
    flash[:success] = "Scene deleted successfully!"
    redirect_to listing_path
  end
  
  private
  
  def set_scene
    @scene = Scene.find(params[:id])
  end
  
  def scene_params
    params.require(:scene).permit(:title, :description)
  end
  
end