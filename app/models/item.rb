class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :burden
  belongs_to :area
  belongs_to :prefecture

  with_options presence: true do
  #商品名、説明、画像、価格なしだと保存できないようにする
    validates :name
    validates :description
    validates :price
    validates :image

    #activehashに対してカラでは保存できないようにする
    validates :category_id
    validates :item_status_id
    validates :delivery_burden_id
    validates :prefecture_id
    validates :delivery_day_id
    
end
