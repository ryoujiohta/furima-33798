FactoryBot.define do
  factory :user do
    nickname           { Faker::Name.last_name }
    email              { Faker::Internet.free_email }
    password            { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name          { Faker::Japanese::Name.last_name }
    first_name         { Faker::Japanese::Name.first_name }
    last_name_kana     { 'テスト' }
    first_name_kana    { 'タロウ' }
    birth_day           { '1989-10-06'}

  end
end


