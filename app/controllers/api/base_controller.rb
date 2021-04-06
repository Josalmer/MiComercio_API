class Api::BaseController < ActionController::API
  before_action :authenticate_api_v1_user!
  before_action :set_locale

  private

  def set_locale
    I18n.default_locale = request.headers["language"] || :es
  end
end
