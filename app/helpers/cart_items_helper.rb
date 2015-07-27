module CartItemsHelper

  def cart_items
    @items = current_user.cart.cart_items.order(quantity: :desc)
  end

end
