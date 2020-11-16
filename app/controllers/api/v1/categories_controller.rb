class Api::V1::CategoriesController < Api::BaseController
  respond_to :json

  def index
    @categories = CompanyCategory.all
  end
end
