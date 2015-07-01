class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings
  has_and_belongs_to_many :users
  validates :title, :description, :price, :in_stock, presence: true
end
