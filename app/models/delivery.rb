class Delivery < ActiveRecord::Base
  has_one :order
end
