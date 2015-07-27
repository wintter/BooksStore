class OrdersController < ApplicationController
  load_and_authorize_resource through: :current_user, only: :index
  authorize_resource
  include Wicked::Wizard
  steps :order_address, :order_delivery, :order_payment, :order_confirm

  def index
  end

  def show
    case step
      when :order_address
        @address = Address.new
      when :order_delivery
      when :order_payment
         @credit_card = CreditCard.new
      else
      @items = cart_items
      @total_price = Order.get_total_price(current_user, session[:order_delivery])
    end
    render_wizard
  end

  def create
    @cart = current_user.cart
    @order = Order.new
    @order.create_order(current_user, session['order_address'],
                        session['order_creditcard'], session['order_delivery'], @cart)
    @cart.cart_items.destroy_all
    flash[:success] = 'Your order has successfully created'
    redirect_to root_path
  end

  def update
      case step
        when :order_address
          @check = check_valid_request(Address, order_address_params)
        when :order_delivery
          session['order_delivery'] = params[:delivery]
          @check = true if order_delivery_params
        when :order_payment
          @check = check_valid_request(CreditCard, order_credit_cards_params)
        else
        create
      end
      @check ? (redirect_to next_wizard_path) : (render_wizard)
  end

  private

    def order_address_params
      params.require(:address).permit(:billing_address, :shipping_address, :city, :phone, :zip)
    end

    def order_credit_cards_params
      params.require(:credit_card).permit(:number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name)
    end

    def order_delivery_params
      delivery = %w'5 10 15'
      true if delivery.include? session['order_delivery']
    end

end
