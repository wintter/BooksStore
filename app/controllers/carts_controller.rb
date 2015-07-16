class CartsController < ApplicationController
  before_action :create
  before_action :check_login_user, only: [:index, :create, :update, :destroy]

  def index
    @items = @cart.cart_items.order(quantity: :desc)
  end

  def create
    @cart = Cart.where(user: current_user).first_or_create
  end

  def update
    cart_item = @cart.cart_items.where(book_id: params[:id]).first
    if cart_item
      cart_item.increment!(:quantity)
    else
      @cart.cart_items << CartItem.new(cart: @cart, book_id: params[:id], quantity: 1)
    end
    flash[:success] = 'Book "'<< Book.find(params[:id]).title << '" has added to cart'
    redirect_to(:back)
  end

  def destroy
    if params[:reduce] && CartItem.find(params[:id]).quantity != 1
      CartItem.find(params[:id]).decrement!(:quantity)
    else
      CartItem.find(params[:id]).destroy
    end
    redirect_to action: 'index'
  end

end
