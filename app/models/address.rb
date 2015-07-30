class Address < ActiveRecord::Base
  #belongs_to :user
  has_one :order
  validates :street_address, :city, presence: true
  validates :phone, :zip, presence: true, format: { with: /\d/ }
end
