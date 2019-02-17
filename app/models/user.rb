# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, length: { maximum: 100 }, format: /\A[\p{L}\p{M}]+\z/
  validates :email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_date :date_of_birth, allow_blank: true, before: -> { Date.today },
                                 before_message: 'must be in the past.'
  validates :phone_number, allow_blank: true, telephone_number: { country: proc { |user| user.country_alpha2 },
                                                                  types: %i[area_code_optional fixed_line mobile] }

  has_one :address
  has_one :company

  accepts_nested_attributes_for :address, :company

  def country_alpha2
    c = ISO3166::Country.find_country_by_name(address.country)
    c.alpha2.to_sym
  end
end
