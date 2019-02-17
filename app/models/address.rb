class Address < ApplicationRecord
  validates :street, :city, presence: true
  validates :zip_code, presence: true, zipcode: true
  validates :country, presence: true, inclusion: { in: ISO3166::Country.all.map(&:name).concat(ISO3166::Country.all.map(&:names)).flatten }

  belongs_to :user, optional: true
  belongs_to :company, optional: true

  def country_alpha2
    c = ISO3166::Country.find_country_by_name(country)
    c.alpha2.to_sym
  end
end
