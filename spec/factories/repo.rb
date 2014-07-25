FactoryGirl.define do
  sequence :repo_owner_and_name do |n|
    "repo_owner_#{n}/repo_name_#{n}"
  end

  factory :repo do
    owner_and_name { generate(:repo_owner_and_name) }
  end
end
