class CartsController < ApplicationController
  before_action :create
  authorize_resource

  def index
    @items = @cart.cart_items.order(quantity: :desc)
  end

  def create
    @cart = Cart.where(user: current_user).first_or_create
  end

  def update
    @book = Book.find(params[:id])
    @cart_item = @cart.cart_items.where(book: @book).first
    if @cart_item
      @cart_item.increment!(:quantity)
    else
      @cart.cart_items << CartItem.new(cart: @cart, book: @book, quantity: 1)
    end
    flash[:success] = 'Book "'<< @book.title << '" has added to cart'
    redirect_to(:back)
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    if params[:reduce] && @cart_items.quantity != 1
      @cart_items.decrement!(:quantity)
    else
      @cart_items.destroy
    end
    redirect_to action: 'index'
  end

end
