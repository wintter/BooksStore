class CartItemsController < ApplicationController
  before_action :initialize_cart
  load_and_authorize_resource through: :cart

  def index
  end

  def update
    @cart_item.increment!(:quantity)
    redirect_to(:back)
  end

  def destroy
    if params[:reduce] && @cart_item.quantity != 1
      @cart_item.decrement!(:quantity)
    else
      @cart_item.destroy
    end
    redirect_to action: 'index'
  end

end
