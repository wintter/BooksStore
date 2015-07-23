module CartsHelper

  def cart_items
    @items = Cart.where(user: current_user).first.cart_items.order(quantity: :desc)
  end

end
