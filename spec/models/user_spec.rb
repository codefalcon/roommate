# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  phone           :string(255)
#  company         :string(255)
#  college         :string(255)
#  age             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "tarzan", email: "tarzan@jungle.com", phone: "123456", company: "JungleInc", college: "Survival College", age: 25,
password: "tarzan", password_confirmation: "tarzan" ) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:company) }
  it { should respond_to(:college) }
  it { should respond_to(:age) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }


  describe "name should not be empty" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "email should not be empty" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "phone should not be empty" do
    before { @user.phone = " " }
    it { should_not be_valid }
  end

  describe "company should not be empty" do
    before { @user.company = " " }
    it { should_not be_valid }
  end

  describe "college should not be empty" do
    before { @user.college = " " }
    it { should_not be_valid }
  end

  describe "age should not be empty" do
    before { @user.age = " " }
    it { should_not be_valid }
  end
  
  describe "name should be <= 30 chars" do
    before { @user.name = 'a' * 31 }
    it { should_not be_valid }
  end
  
  describe "age should be <= 120" do
    before { @user.age = 121 }
    it { should_not be_valid }
  end
  describe "age should be > 14" do
    before { @user.age = 14 }
    it { should_not be_valid }
  end
  
  describe "company should be <= 30 chars" do
    before { @user.company = 'a' * 31 }
    it { should_not be_valid }
  end
  
  describe "college should be <= 30 chars" do
    before { @user.college = 'a' * 31 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                           foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_email|
        @user.email = invalid_email
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      #addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses = %w[user@goo.com]
      addresses.each do |valid_email|
        @user.email = valid_email
        @user.should be_valid
      end
    end
  end
  describe "when email address is taken" do
    before do
      @user_with_same_email = @user.dup
      @user_with_same_email.email = @user.email.upcase
      @user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is empty" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  describe "when password is nil" do
    before { @user.password = @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  describe "when password confirmation does not mathc" do
    before { @user.password = "sure mismatch!@" }
    it { should_not be_valid }
  end

  describe "password should be greater than 6 characters" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate('invalid') }

      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false }
    end
  end
end
