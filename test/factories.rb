FactoryGirl.define do
  factory :repo do
    sequence(:full_name) {|n| "foo#{ n }/bar#{ n }"}
  end

  factory :category do
  end

  factory :user do
  end
end
