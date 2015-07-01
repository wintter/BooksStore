class CartsController < ApplicationController
  before_action :create
  before_action :check_login_user, only: [:index, :create, :update, :destroy]

  def index
    @items = @cart.cart_items
  end

  def create
    @cart = Cart.where(user: cur_user).first_or_create
  end

  def update
    cart_item = @cart.cart_items.where(book_id: params[:id]).first
    if cart_item
      cart_item.quantity+=1
      cart_item.save
    else
      @cart.cart_items << CartItem.new(cart: @cart, book_id: params[:id], quantity: 1)
    end
    flash[:success] = 'Book "'<< Book.find(params[:id]).title << '" has added to cart'
    redirect_to(:back)
  end

  def destroy
    CartItem.find(params[:id]).destroy
    redirect_to action: 'index'
  end

end
