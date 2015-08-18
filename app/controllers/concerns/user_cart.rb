module UserCart

  def initialize_cart
    @cart = current_user.cart
  end

  def calculate_price
    return @cart.update(total_price: nil) if @cart.order_items.empty?
    price = @cart.order_items.map { |item| item.quantity*item.book.price }.inject(&:+)
    @cart.update(total_price: price - @cart.discount)
  end

end
