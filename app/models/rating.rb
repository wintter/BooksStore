class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  scope :approved, -> { where.not(review: nil) }

  class << self

    def get_rate(book, user)
      @rating = where(book: book, user: user).first
      @rating ? @rating.rating_number : 0
    end

    def get_review(book)
      @review = where(book: book, approve: true).all
    end

  end

end
