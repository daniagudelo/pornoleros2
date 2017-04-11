require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "Mashrur2", email: "mashrur2@example.com",
                          password: "password", password_confirmation: "password")
  end
  
  test "should get users index" do
    get users_path
    assert_response :success
  end
  
  test "should get users listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.username
    assert_select "a[href=?]", user_path(@user2), text: @user2.username
  end

end
