class OrderItemsController < ApplicationController
  include UserCart::InitCart, UserCart::CalcPrice
  load_and_authorize_resource

  def index
  end

  def update
    @order_item.increment!(:quantity)
    redirect_to(:back)
  end

  def destroy
    if params[:reduce] && @order_item.quantity != 1
      @order_item.decrement!(:quantity)
    else
      @order_item.destroy
    end
    redirect_to action: 'index'
  end

end
