require 'test_helper'

class ScenesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Mashrur", email: "mashrur@example.com")
    @scene = Scene.create(title: "First scene title", description: "Description of the scene", user: @user)
  end
  
  test "successfully delete a scene" do
    get listing_path
    assert_template 'scenes/listing'
    assert_select 'a[href=?]', scene_path(@scene), text: 'Delete'
      assert_difference 'Scene.count', -1 do
      delete scene_path(@scene)
    end
    assert_redirected_to listing_path
    assert_not flash.empty?
  end
end
