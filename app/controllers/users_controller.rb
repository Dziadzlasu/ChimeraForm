# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_address
    @user.build_company.build_address
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully registered.' }
      else
        format.html { render :new }
      end
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :date_of_birth, :phone_number,
                                 address_attributes: %i[street city zip_code country],
                                 company_attributes: [:name, address_attributes: %i[street city zip_code country]])
  end
end
