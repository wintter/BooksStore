class Coupon < ActiveRecord::Base
  has_many :order
end
