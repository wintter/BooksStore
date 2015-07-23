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
        by_text text
      else
        @author = Author.by_author text
        where(author: @author)
      end
    end

    def save_image filename, id
      image = MiniMagick::Image.read(filename.read)
      image.resize "170x200"
      image_name = "img_book" << id << ".png"
      image.write "#{Rails.root}/app/assets/images/" << image_name
      find(id).update_attribute(:image, image_name)
    end

  end

end
