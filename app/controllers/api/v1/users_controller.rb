class Api::V1::UsersController < Api::BaseController
  respond_to :json

  def show
    @user = current_api_v1_user
  end

  def update
    if current_api_v1_user.update(user_params)
      render partial: 'api/v1/users/user', locals: { user: current_api_v1_user }
    else
      render json: current_api_v1_user.errors, status: :not_acceptable
    end
  end

  def update_payment_preferences
    if current_api_v1_user.payment_preference.update(payment_params)
      render partial: 'api/v1/users/user', locals: { user: current_api_v1_user }
    else
      # :nocov:
      render json: current_api_v1_user.payment_preference.errors, status: :not_acceptable
      # :nocov:
    end
  end

  private

  def user_params
    params[:user].permit(:email, :name, :surname, :phone, :password)
  end

  def payment_params
    params[:newPaymentPreference].permit(:payment_type, :bank, :number, :expiration_month, :expiration_year)
  end
end
