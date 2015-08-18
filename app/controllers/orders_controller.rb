class OrdersController < ApplicationController
  load_and_authorize_resource only: :index
  authorize_resource
  before_action :initialize_cart
  after_filter :calculate_price, only: [:coupon]
  layout 'layouts/order', except: :index

  def index
    @orders = @orders.valid_orders
  end

  def create
    @cart.checkout!
    flash[:success] = 'Your order has successfully created'
    redirect_to root_path
  end

  def coupon
    @coupon = Coupon.find_by(number: params[:coupon])
    if @coupon
      if @cart.coupon
        flash[:error] = 'You already use coupon code'
      else
        @cart.update(coupon: @coupon)
        flash[:success] = 'Coupon code has been accepted'
      end
    else
      flash[:error] = 'Coupon not found'
    end
    redirect_to(:back)
  end

end
