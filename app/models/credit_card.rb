class CreditCard < ActiveRecord::Base
  #belongs_to :user
  has_one :order
  validates :number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name, presence: true
end
