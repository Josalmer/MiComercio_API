class Api::V1::AssessmentsController < Api::BaseController
  respond_to :json

  def index
    @assessments = UserCompanyAssessment.filled.by_user(current_api_v1_user.id).ordered_by_filled_date_asc
  end

  def update
    load_assessment
    if @assessment.update_attributes(filled_assessment)
      @assessment.update_columns(filled_at: Time.current)
      render partial: 'api/v1/assessments/assessment', locals: { assessment: @assessment }
    else
      render json: @assessment.errors, status: 422
    end
  end

  private

  def load_assessment
    @assessment = UserCompanyAssessment.by_user_and_company(current_api_v1_user.id, company_id['company_id']).first
  end

  def company_id
    params.permit(:company_id)
  end

  def filled_assessment
    params.permit(:text, :puntuality, :attention, :satisfaction)
  end

end
