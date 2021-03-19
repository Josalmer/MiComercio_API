class Api::V1::FavoriteCompaniesController < Api::BaseController
  respond_to :json

  def create
    favorite = FavoriteCompany.new(company_id: get_company['id'], user_id: current_api_v1_user.id)
    favorite.save ? (head 200) : (head 422)
  end

  def destroy
    company = Company.find(get_company['id'])
    favorite = company.favorite_companies.by_user(current_api_v1_user.id).first
    favorite.destroy ? (head 200) : (head 422)
  end

  private
  def get_company
    params.permit(:id)
  end
end
