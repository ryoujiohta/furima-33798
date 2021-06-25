require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品出品' do
      context '商品が出品できる時' do
        it '全てが存在する時' do
          expect(@item).to be_valid
        end

        it 'priceが半角数字であれば出品できる' do
          @item.price = 300_000
          expect(@item).to be_valid
        end
      end

      context '商品が出品できない場合' do
        it 'image(商品画像)が空だと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("出品画像を入力してください")
        end

        it 'name（商品名）が空だと出品できない' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品名を入力してください")
        end

        it 'description（商品の説明）が空だと出品できない' do
          @item.description = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        end

        it 'category_id（カテゴリーの情報）が空だと出品できない' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
        end

        it 'category_idが0（--の表示）だと出品できない' do
          @item.category_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('カテゴリーは0以外の値にしてください')
        end

        it 'condition（商品の状態）が空だと出品できない' do
          @item.condition_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の状態を入力してください")
        end

        it 'conditionが0（--の表示）だと出品できない' do
          @item.condition_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の状態は0以外の値にしてください')
        end

        it 'burden_id（配送料の負担について）が空だと出品できない' do
          @item.burden_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
        end

        it 'burden_idが0（--の表示）だと出品できない' do
          @item.burden_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('配送料の負担は0以外の値にしてください')
        end

        it 'prefecture_id（発送元の地域）が空だと出品できない' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
        end

        it 'prefecture_idが0（--の表示）だと出品できない' do
          @item.prefecture_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('発送元の地域は0以外の値にしてください')
        end

        it 'area_id（発送までの日数）が空だと出品できない' do
          @item.area_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
        end

        it 'area_idが0（--の表示）だと出品できない' do
          @item.area_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('発送までの日数は0以外の値にしてください')
        end

        it 'price（販売価格）が空だと出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("価格を入力してください")
        end

        it 'price（販売価格）が¥300~¥9,999,999でないと出品できない' do
          @item.price = 99
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は一覧にありません')
        end

        it 'priceが10,000,000以上では登録できないこと' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は一覧にありません')
        end

        it 'priceが全角数字だと出品できない' do
          @item.price = '５００'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は一覧にありません')
        end

        it 'priceが英数混合では出品できない' do
          @item.price = 'aaa400'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は一覧にありません')
        end

        it 'priceが半角英語のみでは出品できない' do
          @item.price = 'aaaaa'
          @item.valid?
          expect(@item.errors.full_messages).to include('価格は一覧にありません')
        end

        it 'userが紐付いていない場合は出品できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('Userを入力してください')
        end
      end
    end
  end
end
