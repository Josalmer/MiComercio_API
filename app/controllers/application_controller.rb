class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    sign_out current_user
    redirect_to new_session_path(User), alert: exception.message
  end

  private

  def set_locale
    I18n.default_locale = request.headers["language"] || :es
  end
end
