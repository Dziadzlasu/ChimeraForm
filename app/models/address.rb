class Address < ApplicationRecord
  validates :street, :city, presence: true
  validates :zip_code, presence: true
  validates :country, presence: true, inclusion: { in: ISO3166::Country.all.map(&:name).concat(ISO3166::Country.all.map(&:names)).flatten }

  belongs_to :user, optional: true
  belongs_to :company, optional: true
end
