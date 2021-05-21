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
    validates :condition_id
    validates :burden_id
    validates :prefecture_id
    validates :area_id
  end

  
    
end
