class Author < ActiveRecord::Base
  validates :firstname, :lastname, :biography, presence: true
  has_many :books
end
