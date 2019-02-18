# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should belong_to(:company).optional }
  end

  describe 'validations' do
    let(:user) { User.new }

    context "for company" do
      before { allow(subject).to receive(:company?).and_return(true) }
      it { should_not validate_presence_of(:street) }
      it { should_not validate_presence_of(:zip_code) }
      it { should_not validate_presence_of(:country) }

      before do
        user.build_address
        user.build_company
        user.company.build_address
      end

      it 'validates zip code format for US if present' do
        user.company.address.zip_code = '85034'
        user.company.address.country = 'United States'
        user.valid?
        expect(user.errors.full_messages).not_to include('Company address zip code is invalid')
      end

      it 'validates zip code format for PL if present' do
        user.company.address.zip_code = '01-001'
        user.company.address.country = 'Poland'
        user.valid?
        expect(user.errors.full_messages).not_to include('Company address zip code is invalid')
      end

      it 'validates zip code format for UK present' do
        user.company.address.zip_code = 'SW1A 0PW'
        user.company.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Company address zip code is invalid')
      end

      it 'returns error for UK zip code for US if present' do
        user.company.address.zip_code = 'SW1A 0PW'
        user.company.address.country = 'United States'
        user.valid?
        expect(user.errors.full_messages).to include('Company address zip code is invalid')
      end

      it 'validates country if present' do
        user.company.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Company address country is not included in the list')
      end

      it 'returns error if country name is wrong' do
        user.company.address.country = 'Wonderland'
        user.valid?
        expect(user.errors.full_messages).to include('Company address country is not included in the list')
      end

      describe 'zipcode_with_country' do
        it 'returns custom error if zip code is given without country' do
          user.company.address.zip_code = 'EC1A 1BB'
          user.valid?
          expect(user.errors.full_messages).to include('Company address zip code needs country input to validate format')
        end

        it "doesn't return error if zip code and valid country are given" do
          user.company.address.zip_code = 'EC1A 1BB'
          user.company.address.country = 'United Kingdom'
          user.valid?
          expect(user.errors.full_messages).not_to include('Company address zip code needs country input to validate format')
        end
      end
    end

    context 'for user' do
      before { allow(subject).to receive(:company?).and_return(false) }
      it { should validate_presence_of(:street) }
      it { should validate_presence_of(:zip_code) }
      it { should validate_presence_of(:country) }

      before do
        user.build_address
      end

      it 'validates zip code format for US if present' do
        user.address.zip_code = '85034'
        user.address.country = 'United States'
        user.valid?
        expect(user.errors.full_messages).not_to include('Address zip code is invalid')
      end

      it 'validates zip code format for PL if present' do
        user.address.zip_code = '01-001'
        user.address.country = 'Poland'
        user.valid?
        expect(user.errors.full_messages).not_to include('Address zip code is invalid')
      end

      it 'validates zip code format for UK present' do
        user.address.zip_code = 'SW1A 0PW'
        user.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Address zip code is invalid')
      end

      it 'returns error for UK zip code for US if present' do
        user.address.zip_code = 'SW1A 0PW'
        user.address.country = 'United States'
        user.valid?
        expect(user.errors.full_messages).to include('Address zip code is invalid')
      end

      it 'validates country if present' do
        user.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Address country is not included in the list')
      end

      it 'returns error if country name is wrong' do
        user.address.country = 'Wonderland'
        user.valid?
        expect(user.errors.full_messages).to include('Address country is not included in the list')
      end
    end
  end
end
