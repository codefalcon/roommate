require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home Page" do
    before { visit root_path }

    describe "should have h1" do
      it { should have_selector('h1', text: 'Roommate') }
      it { should have_selector('title',text: "Roommate.in") }
    end
  end
end
