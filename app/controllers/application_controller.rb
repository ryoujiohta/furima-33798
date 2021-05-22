class ApplicationController < ActionController::Base
  # application_controller.rb ファイルにnameカラムの保存を可能とする記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # データベースに保存する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day])
  end
end
