# frozen_string_literal: true

class Address < ApplicationRecord
  with_options unless: :company? do |company|
    company.validates :street, :city, presence: true
    company.validates :zip_code, presence: true, zipcode: true
    company.validates :country, presence: true,
                                inclusion: { in: ISO3166::Country.all.map(&:name).concat(ISO3166::Country.all.map(&:names)).flatten }
  end

  validates :zip_code, allow_blank: true, zipcode: true
  validates :country, allow_blank: true,
                      inclusion: { in: ISO3166::Country.all.map(&:name).concat(ISO3166::Country.all.map(&:names)).flatten }

  belongs_to :user, optional: true
  belongs_to :company, optional: true

  def country_alpha2
    c = ISO3166::Country.find_country_by_name(country)
    c.alpha2.to_sym
  end

  def company?
    company.present?
  end
end
