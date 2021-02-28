class Api::V1::CompaniesController < Api::BaseController
  def show
    load_company
  end

  def index
    @companies = Company.publisheds.ordered_by_boost
  end

  def create
    if current_api_v1_user.organization_manager
      company = Company.new(name: create_company[:name])
      company.company_type = CompanyType.find(create_company[:company_type])
      company.save_resized_image(create_company[:logo]) if create_company[:logo].present?
      company.user = User.find(current_api_v1_user.id)
      if company.save
        @companies = Company.by_manager(current_api_v1_user.id)
        render :index
      else
        render json: company.errors, status: :not_acceptable
      end
    else
      render json: { error: I18n.t('custom.unauthorized_action') }, status: 422
    end
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

  def update_image
    load_company
    if params[:logo].present? && current_api_v1_user.id == @company.user.id
      if @company.save_resized_image(params[:logo])
        render partial: 'api/v1/companies/company', locals: { company: @company }
      else
        render json: @company.errors, status: 422
      end
    end
  end

  def manager_companies
    @companies = Company.by_manager(current_api_v1_user.id)
    render :index
  end

  def companies_locations
    @locations = Address.all.pluck('town').compact.map(&:capitalize).uniq.sort
    render json: @locations, status: 200
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
      # :nocov:
      render json: @company.errors, status: 422
      # :nocov:
    end
  end

  def update_company_address
    address = @company.address
    address.update_attributes(edit_company_address)
  end

  def create_company
    params[:created_company_object].permit(
      :name,
      :company_type,
      :logo
    )
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
      :description,
      :published
    )
  end

  def edit_company_address
    params[:edited_direction_object].permit(
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
