require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
   
    @user = User.new(
      first_name: 'first',
      last_name: "Last",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password",
    )
  end
  describe 'Validations' do
    it "is valid with full information" do 
      expect(@user).to be_valid
    end
    it "is not valid with no email" do 
      @user.email = nil
      expect(@user).to_not be_valid
    end
    it "is not valid with no first name" do 
      @user.first_name = nil
      expect(@user).to_not be_valid
    end
    it "is not valid with no last name" do 
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
    it "is not valid with non matching passwords" do 
      @user.password_confirmation = "test"
      expect(@user).to_not be_valid
    end
    it "is not valid with non unique email" do 
      @user.save
      @user2 = User.new(
        first_name: 'first',
        last_name: "Last",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password",
      )
      expect(@user2).to_not be_valid
    end
    it "is not valid with password shorter than minimum" do
      @user.password = "a"
      @user.password_confirmation = "a"
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it "returns true if they enter valid info" do
      @user.save
      userA = User.authenticate_with_credentials(@user.email, @user.password)
      expect(userA).to be_truthy
    end

    it "returns false if they enter invalid password" do
      @user.save
      userA = User.authenticate_with_credentials(@user.email, "test")
      expect(userA).to be_falsey
    end
    it "returns false if they enter invalid email" do
      @user.save
      userA = User.authenticate_with_credentials("test", @user.password)
      expect(userA).to be_falsey
    end
    it "is valid to enter email with spaces on either side" do 
      @user.save
      @user.email = " test@test.com " 
      userA = User.authenticate_with_credentials(@user.email, @user.password)
      expect(userA).to be_truthy
    end
    it "is not case sensitive on the email" do
      @user.email
      @user.save
      @user.email = " TEST@test.com " 
      userA = User.authenticate_with_credentials(@user.email, @user.password)
      expect(userA).to be_truthy 
    end
  
  end

end
