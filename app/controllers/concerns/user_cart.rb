module UserCart

  def initialize_cart
    @cart = current_user.cart
  end

  def calculate_price
    return @cart.update(total_price: nil) unless @cart.order_items
    price = Book.where(id: @cart.order_items.pluck(:book_id)).sum(:price)
    @cart.coupon ? (discount = @cart.coupon.discount.to_d) : (discount = 0)
    @cart.update(total_price: price - discount)
  end

end
