class Api::V1::UsersController < Api::BaseController
  respond_to :json

  def show
    @user = current_api_v1_user
  end

  def update
    if current_api_v1_user.update_attributes(user_params)
      render partial: 'api/v1/users/user', locals: { user: current_api_v1_user }
    else
      render json: current_api_v1_user.errors, status: :not_acceptable
    end
  end

  private

  def user_params
    params.permit(:email, :name, :surname, :phone, :password)
  end
end
