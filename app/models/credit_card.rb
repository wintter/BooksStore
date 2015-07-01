class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  validates :number, :CVV, presence: true
end
