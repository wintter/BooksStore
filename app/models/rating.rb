class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  scope :approved, -> { where.not(review: nil) }
end
