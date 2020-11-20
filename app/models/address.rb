class Address < ApplicationRecord
  belongs_to :company

  validates :direction, presence: true

  def to_s
    direction
  end
end
