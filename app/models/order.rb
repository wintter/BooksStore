class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  belongs_to :order_state
  belongs_to :address
  has_many :order_items

  before_validation do
    self.order_state ||= OrderState.in_progress
  end

  def create_order(user, address, credit_cards, delivery, cart)
    self.total_price = Order.get_total_price(user, delivery)
    self.create_credit_card(credit_cards)
    self.create_address(address)
    self.user = user
    self.save

    cart.cart_items.each do |item|
      OrderItem.create(quantity: item.quantity, book: item.book, order: self)
    end
  end

  class << self

    def get_total_price(user, delivery)
      items_price = user.cart.cart_items.map { |item| item.quantity*item.book.price }
      items_price.inject(&:+) + delivery.to_i || 0
    end

  end

end
