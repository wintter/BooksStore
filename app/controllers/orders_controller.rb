class OrdersController < ApplicationController
  load_and_authorize_resource only: :index
  authorize_resource
  before_action :initialize_cart
  include Wicked::Wizard, OrderChecker
  after_filter :calculate_price, only: [:coupon]
  steps :order_address, :order_delivery, :order_payment, :order_confirm
  layout 'layouts/order', except: :index

  def index
    @orders = @orders.valid_orders
  end

  def show
    case step
      when :order_address
        @billing_address ||= @cart.billing_address || current_user.billing_address || Address.new
        @shipping_address ||= @cart.shipping_address || current_user.shipping_address || Address.new
      when :order_delivery
        @delivery = Delivery.all
      when :order_payment
        @credit_card ||= @cart.credit_card || CreditCard.new
      else
        return check_previous_step
    end
    render_wizard
  end

  def create
    @cart.checkout!
    flash[:success] = 'Your order has successfully created'
    redirect_to root_path
  end

  def update
      case step
        when :order_address
          @check = create_addresses(order_address_params(:billing_address),
                                    order_address_params(:shipping_address))
        when :order_delivery
          @check = create_delivery(order_delivery_params)
        when :order_payment
          @check = create_credit_card(order_credit_cards_params)
        else
        create
      end
      @check ? (redirect_to next_wizard_path) : (render_wizard)
  end

  def coupon
    @coupon = Coupon.find_by(number: params[:coupon])
    if @coupon
      if @cart.coupon
        flash[:error] = 'You already use coupon code'
      else
        @cart.update(coupon: @coupon)
        flash.now[:success] = 'Coupon code has been accepted'
      end
    else
      flash[:error] = 'Coupon not found'
    end
    redirect_to(:back)
  end

  private

    def order_address_params(type)
      params.require(type).permit(:street_address, :city, :phone, :zip)
    end

    def order_credit_cards_params
      params.require(:credit_card).permit(:number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name)
    end

    def order_delivery_params
      params[:delivery] if Delivery.find_by_id(params[:delivery])
    end

end
