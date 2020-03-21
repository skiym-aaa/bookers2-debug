class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception

  protected
  # sign in後のredirect先変更
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :postcode, :prefecture_name, :address_city, :address_street, :latitude, :longitude])
    #sign_upの際にnameのデータ操作を許可。追加したカラム。
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    # ログイン時にnameを使用
  end
end
