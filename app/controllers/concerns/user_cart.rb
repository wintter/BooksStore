module UserCart

  def initialize_cart
    @cart = Order.find_or_create_by(user: current_user, state: 'in_progress')
  end

  def calculate_price
    price = @cart.order_items.map { |item| item.quantity*item.book.price }.inject(&:+)
    @cart.coupon ? (discount = @cart.coupon.discount.to_d) : (discount = 0)
    @cart.update(total_price: price - discount)
  end

end
