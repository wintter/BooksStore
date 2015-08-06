 class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings
  has_many :wish_lists

  validates :title, :description, :price, :in_stock, presence: true
  mount_uploader :cover, CoverUploader
  skip_callback :commit, :after, :remove_previously_stored_cover

  scope :by_text, ->(text) { where("title LIKE '%#{text}%'") }

  class << self

    def search(type, text)
      if type.eql? '1'
        by_text text
      else
        @author = Author.by_author text
        where(author: @author)
      end
    end

  end

  def number(user)
    @rating = ratings.find_by(user: user)
    @rating ? @rating.rating_number : 0
  end

  def reviews
    ratings.where(book: self, approve: true)
  end

end
