FactoryGirl.define do
  factory :url do
    address Faker::Internet.url
    clicks 0
  end

end
