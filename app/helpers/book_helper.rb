module BookHelper

  def initialize *args
    super
    @categories = Category.all
    @authors = Author.all
  end

end
