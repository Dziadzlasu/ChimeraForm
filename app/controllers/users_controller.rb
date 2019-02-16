class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
    @user.build_address
    # @user.build_company
  end

  def edit
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

  def update
  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :date_of_birth, :phone_number,
                                 address_attributes: [:street, :city, :zip_code, :country])
  end
end
