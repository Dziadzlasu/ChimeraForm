# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(100) }
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_most(100) }
    it { should validate_presence_of(:email) }
    it { should allow_value('email@address.com').for(:email) }
    it { should allow_value('email.email@address.com').for(:email) }
    it { should_not allow_value('email').for(:email) }
    it { should_not allow_value('@address.com').for(:email) }
    it { should_not allow_value('address.com').for(:email) }
    it do
      should allow_value('', nil, '10.02.2019', '10-02-2019',
                         '10/02/2019', '2018-02-28', '2018/02/28').for(:date_of_birth)
    end
    it do
      should_not allow_value('30/02/2019', '10.02.2030',
                             '10.02', '02-2030').for(:date_of_birth)
    end
    it { should allow_value(nil, '').for(:phone_number) }

    context 'with valid country input' do
      it 'validates international mobile phone number format for US' do
        user = User.new
        user.phone_number = '1-541-754-3010'
        user.build_address
        user.address.country = 'United States'
        user.valid?
        expect(user.errors.full_messages).not_to include('Phone number is invalid')
      end
      it 'validates national phone number format for US' do
        user = User.new
        user.phone_number = '202.334.6000'
        user.build_address
        user.address.country = 'United States'
        user.valid?
        expect(user.errors.full_messages).not_to include('Phone number is invalid')
      end
      it 'validates international phone number format for UK' do
        user = User.new
        user.phone_number = '+ 44 (0) 207 2913 520'
        user.build_address
        user.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Phone number is invalid')
      end
      it 'validates national phone number format for UK' do
        user = User.new
        user.phone_number = '207 2913 520'
        user.build_address
        user.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Phone number is invalid')
      end
      it 'validates mobile phone number format for UK' do
        user = User.new
        user.phone_number = '7712345678'
        user.build_address
        user.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).not_to include('Phone number is invalid')
      end
      it 'returns error for incorrect phone number for UK' do
        user = User.new
        user.phone_number = '+44 7911 123456'
        user.build_address
        user.address.country = 'United Kingdom'
        user.valid?
        expect(user.errors.full_messages).to include('Phone number is invalid')
      end
      it 'validates mobile phone number format for PL' do
        user = User.new
        user.phone_number = '+48502123456'
        user.build_address
        user.address.country = 'Poland'
        user.valid?
        expect(user.errors.full_messages).not_to include('Phone number is invalid')
      end
    end
  end

  describe 'associations' do
    it { should have_one(:address) }
    it { should have_one(:company) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:address) }
    it { should accept_nested_attributes_for(:company) }
  end
end
