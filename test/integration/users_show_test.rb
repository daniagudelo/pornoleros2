require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "Mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @scene = Scene.create(title: "First scene title", description: "Description of the scene", user: @user)
    @scene2 = @user.scenes.build(title: "Second scene title", description: "Description of the second scene")
    @scene2.save
  end
  
  test "should get user show" do
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.username.capitalize, response.body
  end

end
