class CompanyType < ApplicationRecord
  belongs_to :company_category
  delegate :category, to: :company_category

  def type
    company_type
  end

  def to_s
    company_type
  end
end
