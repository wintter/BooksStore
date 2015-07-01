class UsersController < ApplicationController
  before_action :check_current_user, only: [:show, :edit, :update]
  before_action :check_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to BooksStore ' << @user.name
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.credit_cards_attributes=(params[:user][:credit_cards_attributes])
    @user.address_attributes=(address_params)
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def address_params
      params.require(:user).require(:address_attributes).permit(:billing_address, :shipping_address)
    end


end
