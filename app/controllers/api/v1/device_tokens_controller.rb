class Api::V1::DeviceTokensController < Api::BaseController
  def update
    return head 422 unless params[:device_token]

    device_token = DeviceToken.find_by(token: params[:device_token])
    if device_token.nil?
      DeviceToken.create(user: current_api_v1_user, token: params[:device_token])
    else
      device_token.update(user: current_api_v1_user)
    end
    head 200
  end
end
