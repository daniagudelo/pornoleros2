require 'test_helper'

class SceneTest < ActiveSupport::TestCase
  
  def setup
    @user = User.create!(username: "username", email: "email@example.com",
                          password: "password", password_confirmation: "password")
    @scene = @user.scenes.build(title: "Scene Title", description: "Scene Description")
  end
  
  test "scene without user should be invalid" do
    @scene.user_id = nil
    assert_not @scene.valid?
  end
  
  test "scene should be valid" do
    assert @scene.valid?
  end
  
  test "title should be present" do
  @scene.title = " "
  assert_not @scene.valid?
  end
  
  test "description should be present" do
    @scene.description = " "
    assert_not @scene.valid?
  end
  
  test "description should not be less than 5 characters" do
    @scene.description = "a" * 3
    assert_not @scene.valid?
  end
  
  test "description should not be more than 500 characters" do
    @scene.description = "a" * 501
    assert_not @scene.valid?
  end
  
end