class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new]

  def new
  end

  def show
  end

  def edit
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
    if @user.update_attributes(user_params_update)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
  end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   address_attributes: [:billing_address, :shipping_address])
    end

    def user_params_update
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                   credit_cards_attributes: [:id, :CVV, :number] ,
                                   address_attributes: [:billing_address, :shipping_address])
    end

end
