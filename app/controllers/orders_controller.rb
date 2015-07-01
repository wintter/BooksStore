class OrdersController < ApplicationController
  before_action :check_login_user, only: [:show, :index, :create]

  def index
    @items = Order.where(user: cur_user.id)
  end

  def create
    @cart = Cart.where(user: cur_user).first_or_create
    @order = Order.create(user: cur_user, credit_card_id: params[:order][:credit_card],
                          total_price: get_total_price, billing_address: params[:billing_address],
                          shipping_address: params[:shipping_address])
    @cart.cart_items.each do |item|
      OrderItem.create(quantity: item.quantity, book: item.book, order: @order)
    end
    CartItem.where(cart: @cart).destroy_all
    flash[:success] = 'Your order has successfully created'
    redirect_to root_path
  end

  private

    def get_total_price
      items_price = @cart.cart_items.map { |item| item.quantity*item.book.price }
      items_price.inject(&:+) || 0
    end

end
