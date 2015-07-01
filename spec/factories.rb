FactoryGirl.define do 

  factory :user do
    name "ironman "
    email "ironman@stark.com"
    phone "123455678"
    company "stark tech"
    college "caltech"
    age 35
    password "ironman"
    password_confirmation "ironman"
  end
end
