class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :credit_card, autosave: true
  belongs_to :delivery, autosave: true
  belongs_to :billing_address, class_name: :Address, autosave: true
  belongs_to :shipping_address, class_name: :Address, autosave: true
  belongs_to :coupon
  has_many :order_items

  validates_associated :billing_address, :shipping_address, :credit_card, :delivery

  scope :valid_orders, -> { where.not(state: 'in_progress').where.not(state: 'canceled') }

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered, after_enter: :send_email
    state :canceled

    event :checkout do
      transitions from: :in_progress, to: :in_queue
    end

    event :confirm do
      transitions from: :in_queue, to: :in_delivery
    end

    event :finish do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: [:in_queue, :in_delivery, :delivered], to: :canceled
    end
  end

  def discount
    coupon ? coupon.discount.to_d : 0
  end

  def next_state
    if aasm.current_state.eql? :in_queue
      self.confirm!
    elsif aasm.current_state.eql? :in_delivery
      self.finish!
    end
  end

  def send_email
    OrderMailer.order_delivered(self.user).deliver_now
  end

  def calculate_total_price
    return self.update(total_price: nil) if self.order_items.empty?
    price = self.order_items.map { |item| item.quantity*item.book.price }.inject(&:+)
    self.update(total_price: price - self.discount)
  end

end
