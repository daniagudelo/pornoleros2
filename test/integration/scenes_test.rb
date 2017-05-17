require 'test_helper'

class ScenesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "peeter", email: "peeter@example.com",
                          password: "password", password_confirmation: "password")
    @scene = Scene.create(title: "First scene title", description: "Description of the scene", user: @user)
    @scene2 = @user.scenes.build(title: "Second scene title", description: "Description of the second scene")
    @scene2.save
  end

  test "Should get scenes index" do
    get scenes_path
    assert_response :success
  end
  
  test "should get the scenes listing" do
    get scenes_path
    assert_template 'scenes/index'
    assert_select "a[href=?]", scene_path(@scene), text: @scene.title
    assert_select "a[href=?]", scene_path(@scene2), text: @scene2.title
  end
  
  test "should get scenes show" do
    get scene_path(@scene)
    assert_template 'scenes/show'
    assert_match @scene.title, response.body
    assert_match @scene.description, response.body
  end
  
  test "should create new valid scene" do
    sign_in_as(@user, "password")
    get new_scene_path
    assert 'scenes/new'
    title_of_scene = "Scene title"
    description_of_scene = "Scene description"
    assert_difference 'Scene.count' do
      post scenes_path, params: { scene: { title: title_of_scene, description: description_of_scene } }
    end
    follow_redirect!
    assert_match title_of_scene.capitalize, response.body
    assert_match description_of_scene, response.body
  end
  
  test "reject invalid scene submission" do
    sign_in_as(@user, "password")
    get new_scene_path
    assert_template 'scenes/new'
    assert_no_difference 'Scene.count' do
      post scenes_path, params: { scene: { title: nil, description: nil } }
    end
    assert_template 'scenes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
