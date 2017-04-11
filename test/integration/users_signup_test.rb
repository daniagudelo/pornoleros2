require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'should get signup path' do
    get signup_path
    assert_response :success
  end
  
  test 'reject an invalid signup' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: nil, email: nil, password: nil, password_confirmation: nil } }
    end
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test 'accept valid signup' do
    get signup_path
    user_username = 'username'
    user_email = 'user@example.com'
    user_password = user_password_confirmation = "password"
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: user_username, email: user_email, password: user_password, password_confirmation: user_password_confirmation } }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
  end

end
