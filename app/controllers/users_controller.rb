class UsersController < ApplicationController
  before_action :check_current_user, only: [:edit]
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
    @user = User.new(user_params_create)
    if @user.save
      flash[:success] = 'Welcome to BooksStore ' << @user.name
      login @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_update)
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
    def user_params_create
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   address_attributes: [:billing_address, :shipping_address])
    end

    def user_params_update
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   credit_cards_attributes: [:id, :CVV, :number] ,
                                   address_attributes: [:billing_address, :shipping_address])
    end

end
