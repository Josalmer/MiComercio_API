class CompanyCategory < ApplicationRecord
  has_many :company_types

  def to_s
    category
  end
end
