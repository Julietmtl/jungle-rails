require 'rails_helper'

RSpec.describe User, type: :model do
 
  describe 'Validations' do
    before do 
      @user = User.new(first_name: "First", last_name: "Last", email: "test@test.com", password: "password1", password_confirmation: "password1")
      @user1 = User.new(first_name: "Jane", last_name: "Doe", email: "TEST@test.com", password: "password1", password_confirmation: "password1")
    end

    it 'is valid with all the fields' do
      @user.valid?
      @user.errors.full_messages
      expect(@user).to be_valid
    end

    it 'is not valid if passwords does not match' do
      @user.password_confirmation = "password2"
      @user.valid?
      @user.errors.full_messages
      expect(@user).to_not be_valid
    end

    it 'is not valid if first name is nil' do
      @user.first_name = nil
      @user.valid?
      @user.errors.full_messages
      expect(@user).to_not be_valid
    end

    it 'is not valid if last name is nil' do
      @user.last_name = nil
      @user.valid?
      @user.errors.full_messages
      expect(@user).to_not be_valid
    end

    it 'email should be unique' do
      @user.save
      @user1.valid?
      @user1.errors.full_messages
      expect(@user1).to_not be_valid
    end

    it 'is not valid if email is nil' do
      @user.email = nil
      @user.valid?
      @user.errors.full_messages
      expect(@user).to_not be_valid
    end

    it 'should not be valid if password length is less than 8 characters' do
      @user.password = "pppp"
      @user.valid?
      @user.errors.full_messages
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before do 
      @user = User.new(first_name: "First", last_name: "Last", email: "test@test.com", password: "password1", password_confirmation: "password1")
    end

    it 'should allow users to login if they have the correct email and password' do
      @user.save
      user1 = User.authenticate_with_credentials('test@test.com', 'password1')
      expect(@user).to be == user1
    end

    it 'should pass even if email has spaces present in email' do
      @user.save
      user1 = User.authenticate_with_credentials('   test@test.com', 'password1')
      expect(@user).to be == user1
    end

    it 'should pass even if email has capital letters' do
      @user.save
      user1 = User.authenticate_with_credentials('TEST@test.com', 'password1')
      expect(@user).to be == user1
    end
  end
end
