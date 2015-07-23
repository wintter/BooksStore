class Author < ActiveRecord::Base
  validates :firstname, :lastname, :biography, presence: true
  has_many :books

  scope :by_author, ->(author) { where("firstname LIKE '%#{author}%' OR lastname LIKE '%#{author}%'") }
end
