# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one(:address) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:address) }
  end
end
