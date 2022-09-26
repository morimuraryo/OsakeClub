class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except:[:top, :about]
  # before_action ApplicationCntrollerを実行する前に（＝全てのコントローラーの実行前に）
  # devise_controller?  デバイスに関わるがめんに行ったときに
  # configure_permitted_parameters　を行う
  # もしそれが、deviseのコントローラーだったら、configure_permitted_parametersを呼ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  protected

  # santitizer 消毒剤
  # devise_parameterを消毒して、新規登録がめんで、emailを受け取れるようにする
  # 最初は名前を登録にしたが、認証キーをemailからnameに変更したので、逆にemailの値を受け取れなくなった
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
