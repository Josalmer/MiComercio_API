class Api::V1::PasswordsController < ::Devise::PasswordsController
  respond_to :json
  protect_from_forgery except: :create

  protected

  def after_resetting_password_path_for(_resource)
    successful_changed_password_path
  end
end
