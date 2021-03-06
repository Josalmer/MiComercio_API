Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { passwords: :'api/v1/passwords' }

  root 'web#landing_page'

  get 'successful_changed_password', to: 'web#landing_page'

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }
      resources :social_login, only: %i[create update], defaults: { format: :json }
      resource :user, only: %i[show update]
      resource :device_tokens, only: %i[update], defaults: { format: :json }
      patch 'update_manager_preferences' => 'users#update_payment_preferences'
      patch 'update_notification_preferences' => 'users#update_notification_preferences'
      resources :companies
      resources :categories, only: %i[index]
      resources :types, only: %i[index]
      get 'manager_companies' => 'companies#manager_companies'
      get 'locations' => 'companies#companies_locations'
      patch 'company_image/:id' => 'companies#update_image'
      resources :company_hours, only: %i[create destroy]
      resources :special_schedules, only: %i[create destroy]
      resources :calendar_events, only: %i[index]
      resources :appointments, only: %i[create index]
      get 'user_appointments_for_company/:id' => 'appointments#user_appointments_for_company'
      get 'company_appointments/:id' => 'appointments#company_appointments'
      patch 'cancel_appointment/:id' => 'appointments#cancel_appointment'
      patch 'export_appointments' => 'google_calendar_events#export_appointments'
      resources :assessments, only: %i[index update]
      patch 'boost_company' => 'payment_services#boost_company'
      patch 'create_offer' => 'payment_services#create_offer'
      resources :offers, only: %i[index]
    end
  end
end
