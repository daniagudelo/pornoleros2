require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @scene = Scene.create(title: "First scene title", description: "Description of the scene", user: @user)
    @scene2 = @user.scenes.build(title: "Second scene title", description: "Description of the second scene")
    @scene2.save
  end
  
  test 'reject an invalid edit' do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: nil, email: nil } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test 'accept valid edit' do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "Mashrur1", email: "mashrur1@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "Mashrur1", @user.username
    assert_match "mashrur1@example.com", @user.email
  end
  
end
