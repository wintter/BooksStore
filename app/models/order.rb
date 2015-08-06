class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :credit_card
  belongs_to :delivery
  belongs_to :billing_address, class_name: :Address
  belongs_to :shipping_address, class_name: :Address
  belongs_to :coupon
  has_many :order_items

  #scope only for cancan ability
  scope :cart, ->(user) { find_by(user: user, state: 'in_progress') }

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

end
