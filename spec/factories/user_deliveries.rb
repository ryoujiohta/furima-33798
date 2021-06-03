FactoryBot.define do
  factory :user_delivery do
    post_code { '350-1108' }
    prefecture_id { 5 }
    city { '川越市' }
    address { '石原町1−1−1' }
    building_name { 'ときわそう' }
    phone_number { '08011112222' }

    token { 'tok_abcdefghijk00000000000000000' }
  end
end
