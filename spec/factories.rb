FactoryBot.define do
  factory :order do
    cart { nil }
    handled_by_admin { false }
  end

  factory :cart_item do
    cart { nil }
    product { nil }
    quantity { 1 }
  end

  factory :cart do
    user { nil }
  end

  factory :user do
    name  { 'User test' }
    email { 'user@test.org' }
    password { 'testinguser' }
    password_confirmation { 'testinguser' }
  end

  factory :product do
    title { 'Product' }
    description { 'Details' }
    price { 2 }
    image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/shared/sample.png", 'image/png') }
  end
end
