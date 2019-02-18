# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should belong_to(:company).optional }
  end
end
