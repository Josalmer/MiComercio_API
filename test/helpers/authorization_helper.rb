module AuthorizationHelper
  def sign_up(user)
    @json_headers = { "Accept": 'application/json', "Content-Type": 'application/json' }
    post '/api/v1/users/sign_in', as: :json,
                                  headers: @json_headers,
                                  params: {
                                    api_v1_user: {
                                      email: user.email,
                                      password: '123456'
                                    }
                                  }
  end
end
