# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true, length: { maximum: 100 }, format: /\A[\p{L}\p{M}]+\z/
  validates :email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validates :date_of_birth, allow_blank: true
  # validates :phone_number, allow_blank: true

  has_one :address
  has_one :company

  accepts_nested_attributes_for :address, :company
end
