require 'rails_helper'

RSpec.describe UserDelivery, type: :model do
  describe '商品購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @user_delivery = FactoryBot.build(:user_delivery, user_id: @user.id, item_id: @item.id)
      sleep 0.6 # MySQLのエラー防止
    end

    context '購入情報が保存できる時' do
      it '必要な情報を適切に入力すると商品の購入ができる' do
        expect(@user_delivery).to be_valid
      end

      it '建物名の記入がなくても登録できること' do
        @user_delivery.building_name = ''
        expect(@user_delivery).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it 'token（カード情報をトークン化した情報）が空では登録できないこと' do
        @user_delivery.token = nil
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("カード情報を入力してください")
      end

      it 'item_id（出品情報）が空だと登録できない' do
        @user_delivery.item_id = nil
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("Itemを入力してください")
      end

      it 'user_idが空だと登録できない' do
        @user_delivery.user_id = nil
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("Userを入力してください")
      end

      it 'post_code（郵便番号）が空だと購入できない' do
        @user_delivery.post_code = ''
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'prefecture_id（都道府県）が「---」だと購入できない' do
        @user_delivery.prefecture_id = 0
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('都道府県は0以外の値にしてください')
      end

      it 'post_code（郵便番号）にハイフンがなければ購入できない' do
        @user_delivery.post_code = '1234567'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it 'post_code（郵便番号）が全角数字だと購入できない' do
        @user_delivery.post_code = '１２３-４５６７'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it 'city（市区町村）が空だと購入できない' do
        @user_delivery.city = ''
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'address（番地）が空だと購入できない' do
        @user_delivery.address = ''
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_number（電話番号）が空だと購入できない' do
        @user_delivery.phone_number = ''
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_number（電話番号）に記号があると購入できない' do
        @user_delivery.phone_number = '090-1111-2222'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phone_number（電話番号）が12桁だと購入できない' do
        @user_delivery.phone_number = '090111122222'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phone_number（電話番号）が9桁以下だと購入できない' do
        @user_delivery.phone_number = '04811122'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phnoe_number（電話番号）が全角数字だと購入できない' do
        @user_delivery.phone_number = '０９０１１１１２２２２'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'phnoe_number（電話番号）が英数混合では登録できないこと' do
        @user_delivery.phone_number = '080abcd1111'
        @user_delivery.valid?
        expect(@user_delivery.errors.full_messages).to include('電話番号は不正な値です')
      end
    end
  end
end
