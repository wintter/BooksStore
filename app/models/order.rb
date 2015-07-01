class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  has_many :order_items
  validates :state, inclusion: { in: %w(in\ progress completed shipped) }

  before_validation do
    self.state ||= 'in progress'
  end

end
