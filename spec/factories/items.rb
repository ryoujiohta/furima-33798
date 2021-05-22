FactoryBot.define do
  factory :item do
    name                  { 'CRベルセルク新台' }
    description           { '2021年新台のCRベルセルク' }
    price                 { Faker::Address.building_number }
    category_id           { 1 }
    condition_id          { 1 }
    burden_id             { 1 }
    prefecture_id         { 1 }
    area_id               { 1 }

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/test_image.jpg'), filename: 'test_image.png')
    end
  end
end
