class Address < ApplicationRecord
  validates :street, :city, presence: true
  validates :zip_code, presence: true
  validates :country, presence: true

  belongs_to :user, optional: true
  belongs_to :company, optional: true
end
