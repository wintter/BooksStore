class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  scope :approved, -> { where('review IS NOT NULL') }

  class << self

    def get_rate(book, user)
      @rating = Rating.where(book: book, user: user).first
      @rating ? @rating = @rating.rating_number : @rating = 0
    end

    def get_review(book)
      @review = Rating.where(book: book, approve: true).all
    end

  end

end
