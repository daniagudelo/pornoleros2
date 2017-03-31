require 'test_helper'

class SceneTest < ActiveSupport::TestCase
  
  def setup
    @scene = Scene.new(title: "Scene Title", description: "Scene Description")
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