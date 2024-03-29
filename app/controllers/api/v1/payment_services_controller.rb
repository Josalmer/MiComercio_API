class Api::V1::PaymentServicesController < Api::BaseController
  respond_to :json

  def boost_company
    @company = Company.find(boost_company_params['company_id'])
    validity_date = ((Time.current + 1.day).beginning_of_day + boost_company_params['duration'].month)
    payment_service_params = {
      cost: boost_company_params['cost'] * boost_company_params['duration'],
      user_id: current_api_v1_user.id,
      company_id: boost_company_params['company_id'],
      service: "Company Boost: #{boost_company_params['boost_factor']}% for #{boost_company_params['duration']} months"
    }

    ActiveRecord::Base.transaction do
      @company.update_columns(boost_factor: boost_company_params['boost_factor'], boost_validity: validity_date)
      PaymentService.create(payment_service_params)
      render partial: 'api/v1/companies/company', locals: { company: @company }
    end
  end

  def create_offer
    payment_service_params = {
      cost: 20,
      user_id: current_api_v1_user.id,
      company_id: create_offer_params['company_id'],
      service: "Offer"
    }
    offer_params = {
      company_id: create_offer_params['company_id'],
      text: create_offer_params['text'],
      discount: create_offer_params['discount'],
      validity: create_offer_params['validity']
    }

    ActiveRecord::Base.transaction do
      offer = Offer.create(offer_params)
      offer.send_notifications
      PaymentService.create(payment_service_params)
      render json: { success: true }
    end
  end

  private

  def create_offer_params
    params.permit(:company_id, :validity, :discount, :text)
  end

  def boost_company_params
    params.permit(:company_id, :cost, :duration, :boost_factor)
  end
end
