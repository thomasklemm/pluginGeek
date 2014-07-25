FactoryGirl.define do
  sequence :user_login do |n|
    "github_user_#{n}"
  end

  factory :user do
    login { generate(:user_login) }
  end

  factory :user_authentication, class: User::Authentication do
    user
    provider 'github'
    uid { generate(:user_login) }
  end
end
