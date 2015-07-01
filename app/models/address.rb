class Address < ActiveRecord::Base
  belongs_to :user
  validates :billing_address, :shipping_address, presence: true
end
