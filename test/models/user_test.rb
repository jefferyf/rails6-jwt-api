require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "user name", username: "username", email: "user@domain.com", password: "please", password_confirmation: "please")
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without username' do
    @user.username = nil
    @user.valid?
    assert_includes(@user.errors[:username], "can't be blank")  
  end

  test 'invalid with already taken username' do
    User.new(username: "username").save(validate: false)

    user = User.new(username: "username")
    refute user.valid?
    refute user.save
    assert user.errors.messages[:username].include?("has already been taken")  
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?
    refute @user.save
    assert @user.errors.messages[:email].include?("can't be blank") 
  end

  test 'is invalid with taken email' do
    User.new(email: "user@domain.com").save(validate: false)

    refute @user.valid?
    refute @user.save
    assert @user.errors.messages[:email].include?("has already been taken")
  end

  test 'invalid with malformed email' do
    @user.email = 'notanemailaddress'
    refute @user.valid?
    refute @user.save
    assert @user.errors.messages[:email].include?("is invalid")
  end

  test 'is invalid with blank password' do
    @user.password = nil
    refute @user.valid?
    refute @user.save
    assert @user.errors.messages[:password].include?("can't be blank")
  end

  test 'is invalid with password less than 6 characters in length' do
    @user.password = "12345"
    refute @user.valid?
    refute @user.save
    assert @user.errors.messages[:password].include?("is too short (minimum is 6 characters)")
  end

  test 'is invalid if password does not match password_confirmation' do
    @user.password_confirmation = "nonmatch"
    refute @user.valid?
    refute @user.save
    assert @user.errors.messages[:password_confirmation].include?("doesn't match Password")
  end
end
