# frozen_string_literal: true

class Company < ApplicationRecord
  validates :name, allow_blank: true, length: { maximum: 100 }

  belongs_to :user
  has_one :address

  accepts_nested_attributes_for :address
end
