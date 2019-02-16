class Company < ApplicationRecord
  validates :name, allow_blank: true, length: { maximum: 100 }

  has_one :address
  belongs_to :user
end
