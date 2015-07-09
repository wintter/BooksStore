class User < ActiveRecord::Base
  has_many :orders
  has_many :ratings
  has_many :credit_cards
  has_one :cart
  has_one :address
  has_and_belongs_to_many :books
  #need for form_for
  accepts_nested_attributes_for :credit_cards, :address

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: /.+@.+\..+/i }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  private
    def create_remember_token
      self.remember_token = AuthsHelper.encrypt(AuthsHelper.new_remember_token)
    end

end
