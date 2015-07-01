class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  scope :approved, -> { where('review IS NOT NULL') }
end
