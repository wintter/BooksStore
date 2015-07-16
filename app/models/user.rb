class User < ActiveRecord::Base
  has_many :orders
  has_many :ratings
  has_one :cart
  has_and_belongs_to_many :books
  #has_one :address
  #has_many :credit_cards
  #accepts_nested_attributes_for :credit_cards, :address

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: /.+@.+\..+/i }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  class << self

    def facebook_login(auth)
      user = User.find_by(uid: auth['uid'], provider: auth['provider'])
      unless user
        user = User.new(name: auth['info']['name'], email: auth['info']['email'],
                        uid: auth['uid'], provider: auth['provider'],
                        password: '123456', password_confirmation: '123456')
        user.save
      end
      user
    end

  end

  private
    def create_remember_token
      self.remember_token = AuthsHelper.encrypt(AuthsHelper.new_remember_token)
    end

end
