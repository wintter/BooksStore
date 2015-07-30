class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  scope :approved, -> { where.not(review: nil) }
  scope :user_reviews, ->(book) { where(book: book, approve: true) }

  class << self

    def number(book, user)
      @rating = find_by(book: book, user: user)
      @rating ? @rating.rating_number : 0
    end

  end

end
