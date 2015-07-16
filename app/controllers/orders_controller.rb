class OrdersController < ApplicationController
  before_action :check_login_user, only: [:index, :create]

  def index
    @items = Order.where(user: current_user.id)
  end

  def create
    @cart = Cart.where(user: current_user).first

    @order = Order.new
    @order.create_order(current_user, session[:order_address], session[:order_credit_card], session[:order_delivery])

    @cart.cart_items.each do |item|
      OrderItem.create(quantity: item.quantity, book: item.book, order: @order)
    end

    CartItem.where(cart: @cart).destroy_all
    flash[:success] = 'Your order has successfully created'
    redirect_to root_path
  end

  def update
    session[:order_step] = params[:step]
    case session[:order_step]
      when '1' #start orders, fill address field
        @address = Address.new
        render :order_address
      when '2' #save address
        @address = Address.new(order_address_params)
          if @address.valid?
            session[:order_address] = @address.attributes
            render :order_delivery
          else
            render :order_address
          end
      when '3' #save delivery
        session[:order_delivery] = params[:delivery]
        @credit_card = CreditCard.new
        render :order_payment
      when '4' #save credit card
        @credit_card = CreditCard.new(order_credit_cards_params)
        if @credit_card.valid?
          session[:order_credit_card] = @credit_card.attributes
          @items = Cart.where(user: current_user).first.cart_items.order(quantity: :desc)
          @total_price = Order.new.get_total_price(current_user, session[:order_delivery])
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
