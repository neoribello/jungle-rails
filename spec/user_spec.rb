require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    # validation examples here
    it "should have all fields present" do
      user = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123", password_confirmation: "123")
      expect(user).to be_valid
    end

    it "should have a password" do
      user = User.create(name: "Jane Doe", email: "janedoe@email.com", password_confirmation: "123")

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include 'Password can\'t be blank'
    end

    it "should have a password confirmation" do
      user = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123")

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include 'Password confirmation can\'t be blank'
    end

    it "should password and password_confirmation match" do
      user = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123", password_confirmation: "1234")

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include 'Password confirmation doesn\'t match Password'
    end
  end

  it "should check that email is unique" do
    user1 = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123", password_confirmation: "123")

    user2 = User.create(name: "Jane Doe", email: "JanEdoe@email.cOm", password: "123", password_confirmation: "123")
  
    expect(user2).to_not be_valid
  end

  it "should have a name" do
    user = User.create(name: nil, email: "janedoe@email.com", password: "123", password_confirmation: "123")

    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include 'Name can\'t be blank'
  end

  it "should have an email" do
    user = User.create(name: "Jane Doe", email: nil, password: "123", password_confirmation: "123")

    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include 'Email can\'t be blank'
  end

  it "should have the right password length" do
    user = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "12", password_confirmation: "12")

    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include 'Password is too short (minimum is 3 characters)'
  end
  

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'returns a user with valid credentials' do
      @user1 = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123", password_confirmation: "123")

      user = User.authenticate_with_credentials('janedoe@email.com', '123')
      expect(user).to be_an_instance_of(User)
    end

    it 'returns a user with upper and lower case characters' do
      @user1 = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123", password_confirmation: "123")

      user = User.authenticate_with_credentials('JanEdoE@email.com', '123')
      expect(user).to be_an_instance_of(User)
    end

    it 'returns a user with trailing whitespaces' do
      @user1 = User.create(name: "Jane Doe", email: "janedoe@email.com", password: "123", password_confirmation: "123")

      user = User.authenticate_with_credentials('  janedoe@email.com  ', '123')
      expect(user).to be_an_instance_of(User)
    end
  end

end