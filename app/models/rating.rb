class Rating < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book
  validates_inclusion_of :rating_number, :in => 1..10
end
