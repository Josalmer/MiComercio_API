class Api::V1::CompaniesController < Api::BaseController
  def show
    load_company
  end

  def index
    @companies = Company.all
  end

  def update
    load_company
    if current_api_v1_user.id == @company.user.id
      update_company_address
      update_company
    else
      render json: { error: I18n.t('custom.unauthorized_action') }, status: 422
    end
  end

  def manager_companies
    @companies = Company.by_manager(current_api_v1_user.id)
    render :index
  end

  private

  def load_company
    id = company_id['id']
    @company = Company.find(id)
  end

  def company_id
    params.permit(:id)
  end

  def update_company
    if @company.update_attributes(edit_company)
      render partial: 'api/v1/companies/company', locals: { company: @company }
    else
      render json: @company.errors, status: 422
    end
  end

  def update_company_direction
    direction = @company.direction
    direction.update_attributes(edit_company_direction)
  end

  def edit_company
    params[:edited_company_object].permit(
      :diary_client_limit,
      :monthly_client_limit,
      :simultaneous_appointment_number,
      :appointment_duration,
      :web,
      :mail,
      :phone,
      :description
    )
  end

  def edit_company_address
    params[:edited_address_object].permit(
      :cp,
      :town,
      :province,
      :country,
      :direction,
      :latitude,
      :longitude
    )
  end
end
