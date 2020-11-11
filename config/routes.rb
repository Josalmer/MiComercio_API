Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { passwords: :'api/v1/passwords' }

  root 'web#landing_page'

  get 'successful_changed_password', to: 'web#landing_page'

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }
      resource :user, only: %i[show update]
      resources :companies, only: %i[index show update]
      get 'manager_companies' => 'companies#manager_companies'
    end
  end
end
