FactoryGirl.define do
  factory :user do
    sequence(:user_name)  { |n| "User name #{n}" }
    sequence(:first_name)  { |n| "first name #{n}" }
    sequence(:last_name)  { |n| "last name #{n}" }
    sequence(:primary_instrument) { |n| "instrument #{n}" }
    
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end