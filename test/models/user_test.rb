require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: 'username1', email: "email@example.com", 
    password: "password", password_confirmation: "password")
  end
  
  test 'user should be valid' do
    assert @user.valid?
  end
  
  test 'username should be present' do
    @user.username = ' '
    assert_not @user.valid?
  end
  
  test 'username should be more than 3 characters' do
    @user.username = 'a' * 2
    assert_not @user.valid?
  end
  
  test 'username should not be over 30 characters' do
    @user.username = 'a' * 31
    assert_not @user.valid?
  end
  
  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end
  
  test 'email accepts the right format' do
    valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.co.jp john+smith@co.uk.org]
    valid_emails.each do |valids|
     @user.email = valids
     assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "Should reject invalid emails" do
    invalid_emails = %w[user@examplecom MASHRURgmail.com M.first@yahoo,com joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @user.email = invalids
      assert_not @user.valid? "#{invalids.inspect} should be invalid"
    end
  end
  
  test 'email should be unique and case insensitive' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email should be lowercase before hitting the db" do
    mixed_email = "John@example.com"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
  end
  
  test "password should be at least 5 characters long" do
    @user.password = @user.password_confirmation = "x" * 4
    assert_not @user.valid?
  end
end