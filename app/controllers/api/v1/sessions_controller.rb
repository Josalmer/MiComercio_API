class Api::V1::SessionsController < ::Devise::SessionsController
  respond_to :json
  protect_from_forgery except: :create
  before_action :authenticate_api_v1_user!, except: [:create]

  def create
    if params['api_v1_user']['social_token']
      social_login
    else
      db_login
    end
  end

  private

  def social_login
    @user = User.created_by_social_login(params['api_v1_user']['provider']).where(social_token: params['api_v1_user']['social_token']).first
    if @user
      self.resource = warden.set_user(@user)
      sign_in(resource_name, resource)
      render json: { success: true, auth_token: current_token, email: @user.email }
    else
      head 401
    end
  end

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
