class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings
  has_and_belongs_to_many :users
  validates :title, :description, :price, :in_stock, presence: true

  scope :by_text, ->(text) { where("title LIKE '%#{text}%'") }

  class << self

    def search type, text
      if type.eql? '1'
        Book.by_text text
      else
        @author = Author.by_author text
        Book.where(author: @author)
      end
    end

  end

end
