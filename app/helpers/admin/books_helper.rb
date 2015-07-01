module Admin::BooksHelper

  class << self
    def count_entity
      @count_entity = Array.new
      @count_entity << Book.all.count
      @count_entity << Category.all.count
      @count_entity << Author.all.count
      @count_entity << Rating.approved.all.count
    end
  end

end
