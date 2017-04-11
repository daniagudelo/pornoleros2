require 'test_helper'

class ScenesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @scene = Scene.create(title: "First scene title", description: "Description of the scene", user: @user)
  end
  
  test "reject invalid scene update" do
    get edit_scene_path(@scene)
    assert_template 'scenes/edit'
    patch scene_path(@scene), params:  { scene: { title: " ", description: "some description" } }
    assert_template 'scenes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully update scene" do
    get edit_scene_path(@scene)
    assert_template 'scenes/edit'
    updated_scene_title = "Updated title"
    updated_scene_description = "Updated description"
    patch scene_path(@scene), params: { scene: {  title: updated_scene_title, description: updated_scene_description } }
    assert_redirected_to @scene
    #follow_redirect!
    assert_not flash.empty?
    @scene.reload
    assert_match updated_scene_title, @scene.title
    assert_match updated_scene_description, @scene.description
  end
end
