class Api::V1::SocialLoginController < Api::BaseController
  respond_to :json
  before_action :authenticate_api_v1_user!, except: [:create]

  def create # only for existing users or new normal users
    @user = User.created_by_social_login(user_params['provider']).where(social_token: user_params['social_token']).first
    if @user
      render json: { success: true, email: @user.email, social_token: @user.social_token }
    else
      register_social_user
    end
  end

  # def create # allows company manager creation via google login
  #   new_user
  # end

  # def update # allows company manager creation via google login
  #   @user = User.created_by_social_login(user_params['provider']).where(social_token: user_params['social_token']).first
  #   if @user
  #     render json: { success: true, email: @user.email, social_token: @user.social_token }
  #   else
  #     register_social_user
  #   end
  # end

  private

  def register_social_user # only for existing users or new normal users
    @user = User.by_email(user_params['email']).first
    if @user
      assign_social_login_to_user
    else
      new_user
    end
  end

  def new_user # only for existing users or new normal users
    @user = User.new(
      provider: user_params['provider'],
      social_token: user_params['social_token'],
      password: SecureRandom.hex,
      email: user_params['email'],
      name: user_params['name'],
      surname: user_params['surname'],
      organization_manager: false
    )
    if @user.save
      render json: { success: true, email: @user.email, social_token: @user.social_token }
    else
      render json: @user.errors, status: :not_acceptable
    end
  end

  # def register_social_user # allows company manager creation via google login
  #   @user = User.by_email(user_params['email']).first
  #   if @user
  #     assign_social_login_to_user
  #   else
  #     render json: { success: true, new_user: I18n.t('custom.new_account_from_social') }
  #   end
  # end

  # def new_user # allows company manager creation via google login
  #   @user = User.new(
  #     provider: user_params['provider'],
  #     social_token: user_params['social_token'],
  #     password: SecureRandom.hex,
  #     email: user_params['email'],
  #     name: user_params['name'],
  #     surname: user_params['surname'],
  #     organization_manager: user_params['organization_manager']
  #   )
  #   if @user.save
  #     render json: { success: true, email: @user.email, social_token: @user.social_token }
  #   else
  #     render json: @user.errors, status: :not_acceptable
  #   end
  # end

  def assign_social_login_to_user
    if @user.update_columns(provider: user_params['provider'], social_token: user_params['social_token'])
      render json: { success: true, email: @user.email, social_token: @user.social_token }
    else
      render json: @user.errors, status: :not_acceptable
    end
  end

  def user_params
    params.permit(:provider, :social_token, :email, :name, :surname, :organization_manager)
  end
end
