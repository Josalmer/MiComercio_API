RailsAdmin.config do |config|
  config.main_app_name = ["Mi Comercio", "Panel de administración"]

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  config.authorize_with :cancancan

  config.parent_controller = 'ApplicationController'

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.excluded_models = %w[ActiveStorage::Attachment ActiveStorage::Blob]
  excluded_creatable_models = ['Address']

  config.label_methods = [:to_s]

  class RailsAdmin::Config::Fields::Types::Time
    def parse_value(value)
      Time.zone.parse(value)
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except excluded_creatable_models
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Notification do
    navigation_label 'Usuarios'
  end
  config.model User do
    navigation_label 'Usuarios'
    exclude_fields :provider, :social_token
  end
  config.model DeviceToken do
    parent User
  end
  config.model PaymentPreference do
    parent User
  end
  config.model NotificationPreference do
    parent User
  end
  config.model CompanyCategory do
    parent Company
  end
  config.model CompanyType do
    parent Company
  end
  config.model Address do
    parent Company
  end
  config.model CompanyHour do
    parent Company
  end
  config.model SpecialSchedule do
    parent Company
  end
end
