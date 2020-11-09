class Api::V1::SessionsController < ::Devise::SessionsController
  respond_to :json
  protect_from_forgery except: :create
  before_action :authenticate_api_v1_user!, except: [:create]

  def create
    db_login
  end

  private

  def db_login
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { success: true, auth_token: current_token, email: resource.email }
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_to_on_destroy
    head :no_content
  end
end
