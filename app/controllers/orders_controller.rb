class OrdersController < ApplicationController
  authorize_resource

  def index
    @items = Order.where(user: current_user.id)
  end

  def create
    @cart = Cart.where(user: current_user).first

    @order = Order.new
    @order.create_order(current_user, session['orderAddress'], session['orderCreditCard'], session['orderDelivery'])

    @cart.cart_items.each do |item|
      OrderItem.create(quantity: item.quantity, book: item.book, order: @order)
    end

    CartItem.where(cart: @cart).destroy_all
    flash[:success] = 'Your order has successfully created'
    redirect_to root_path
  end

  def update
    case params[:step]
      when '1' #start orders, fill address field
        @address = Address.new
        render :order_address
      when '2' #save address
        check_valid_request(Address, order_address_params) ? (render :order_delivery) : (render :order_address)
      when '3' #save delivery
        session['orderDelivery'] = params[:delivery]
        @credit_card = CreditCard.new
        render :order_payment
      when '4' #save credit card
        if check_valid_request(CreditCard, order_credit_cards_params)
          @items = cart_items
          @total_price = Order.get_total_price(current_user, session[:order_delivery])
          render :order_confirm
        else
          render :order_payment
        end
      else
        create
    end
  end

  private

    def order_address_params
      params.require(:address).permit(:billing_address, :shipping_address, :city, :phone, :zip)
    end

    def order_credit_cards_params
      params.require(:credit_card).permit(:number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name)
    end

end
