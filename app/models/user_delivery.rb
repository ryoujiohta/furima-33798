class UserDelivery
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :address
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 0 }

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                    building_name: building_name, phone_number: phone_number, building_name: building_name, buyer_id: buyer.id)
  end
end
