class ScenesController < ApplicationController
  before_action :set_scene, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @scenes = Scene.paginate(page: params[:page], per_page: 16)
  end
  
  def listing
    @scenes = Scene.all
    redirect_to scenes_path if !logged_in?
  end
  
  def show
  end
  
  def new
    @scene = Scene.new
  end
  
  def create
    @scene = Scene.new(scene_params)
    @scene.user = current_user
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
  
  def require_same_user
    if current_user != @scene.user
      flash[:notice] = "You can only edit or delete your own scenes"
      redirect_to scenes_path
    end
  end
  
  def set_scene
    @scene = Scene.find(params[:id])
  end
  
  def scene_params
    params.require(:scene).permit(:title, :description)
  end
  
end