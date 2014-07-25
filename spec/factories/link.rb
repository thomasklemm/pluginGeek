FactoryGirl.define do
  sequence :link_url do |n|
    "http://example.com/posts/#{n}"
  end

  factory :link do
    title "A post"
    url { generate(:link_url) }
  end
end
