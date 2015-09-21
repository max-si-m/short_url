100.times {
  Url.create(address: Faker::Internet.url, clicks: rand(0..100))
}