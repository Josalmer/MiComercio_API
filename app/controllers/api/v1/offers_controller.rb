class Api::V1::OffersController < Api::BaseController
  before_action :load_companies
  respond_to :json

  def index
    @offers = []
    @companies.each do |company|
      @offers << company.offers.active
    end
    @offers = @offers.flatten
  end

  private
  
  def load_companies
    user = current_api_v1_user
    if user.organization_manager
      @companies = user.companies
    else
      @companies = user.appointments.map(&:company).uniq
    end
  end
end
