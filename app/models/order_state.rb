class OrderState < ActiveRecord::Base
  has_many :orders
  scope :in_progress, -> { where(state: 'in progress').first }
end
