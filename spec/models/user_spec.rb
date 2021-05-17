require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全て通ると登録できる' do
        expect(@user).to be_valid
      end
    end
    
    context '新規登録がうまくいかない時' do

      #ユーザー情報
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'emailが空では登録できない' do
      @user.email = ''  
      @user.valid?
      
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    
    it 'emailが一意性でないと登録できない' do
      @user.save  
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email 
      another_user.valid?
      
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'emailに@が無いと登録できない' do
        @user.email = '！＃'  
        @user.valid?    
        expect(@user.errors.full_messages).to include "Email is invalid"
    end
    
    it 'passwordが空では登録出来ない' do
      @user.password = ''  
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    
    it 'passwordが６文字以上でないと登録できない' do
      @user.password = '12345' 
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end

    it 'passwordは半角英数混合じゃないと登録できない' do
      @user.password = '11111111'
      @user.valid?
      
      expect(@user.errors.full_messages).to include "Password is invalid"
    end

    it 'passwordは英字のみでは登録できないこと' do
      @user.password = 'aaaaaaa'
      @user.valid?

      expect(@user.errors.full_messages).to include "Password is invalid"
    end

    it 'passwordは全角だと登録できないこと' do
      @user.password = 'ａａａａ１１１１'
      @user.valid?

      expect(@user.errors.full_messages).to include "Password is invalid"
    end

    it 'passwordは確認用を含めて2回入力できないと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'パスワードとパスワード確認用は値が一致していない場合登録できない' do
      @user.password = 'a12345'
      @user.password_confirmation = 'a12344'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end



    #本人情報確認
    it 'last_nameが空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_name_kanaが空だと登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが空だと登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'last_name_kanaがカタカナでないと登録できない' do
      @user.last_name_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid')
    end

    it 'first_name_kanaがカタカナでないと登録できない' do
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end

    it 'last_nameが全角でないと登録できない' do
      @user.last_name = 'ﾃｽﾄ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_nameが全角でないと登録できない' do
      @user.first_name = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'birth_dyが空だと登録できない' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end


  end
 end
end