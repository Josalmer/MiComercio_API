class Api::V1::TypesController < Api::BaseController
  respond_to :json

  def index
    @types = CompanyType.all
  end
end
