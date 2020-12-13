class ApplicationController < ActionController::Base
  before_action :basic_auth
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'ayumu' && password == '0113' 
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :password, :password_confirmation, :surname_kanji, :name_kanji, :surname_katakana, :name_katakana, :birthday])
  end
end
