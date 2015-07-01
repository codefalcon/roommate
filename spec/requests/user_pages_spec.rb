require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
  
  describe 'signup' do
    before { visit signup_path }

    let(:submit) { "Create my account" }
    
    describe "invalid submit" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "valid submit" do
      before do 
        fill_in "Name", with: "ironman"
        fill_in "Email", with: "ironman@stark.com"
        fill_in "Phone", with:  "123456"
        fill_in "Company", with: "stark industries"
        fill_in "College", with: "caltech"
        fill_in "Age", with: 35
        fill_in "Password", with: "ironman"
        fill_in "Confirmation", with: "ironman"
      end
      it "should create a new user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
end
