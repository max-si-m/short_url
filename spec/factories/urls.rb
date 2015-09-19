FactoryGirl.define do
  factory :url do
    address Faker::Internet.url
  end
end
