require 'test_helper'

class ScenesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "Mashrur", email: "mashrur@example.com")
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
    assert_match @scene.title, response.body
    assert_match @scene2.title, response.body
  end
  
end
