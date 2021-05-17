class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         has_many :items


         #カラだと保存出来ないバリデーションをかけている
         #以下の全体にバリデーションかけるよ
         with_options presence: true do
        
        #ニックネーム
        validates :nickname

        #誕生日
        validates :birth_day

        #パスワード
        validates :password,format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/}

        #名字と名前を必須にさせる
        #漢字・カタカナ・ひらがなでの入力に制限
        with_options format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ } do
          validates :last_name
          validates :first_name
        end

        #全角カタカナでの入力に制限
        with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
          validates :last_name_kana
          validates :first_name_kana
        end


        end
                                                 
end