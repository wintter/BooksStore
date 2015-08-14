class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :orders
  has_many :ratings
  has_many :wish_lists
  belongs_to :billing_address, class_name: :Address
  belongs_to :shipping_address, class_name: :Address
  accepts_nested_attributes_for :billing_address, :shipping_address

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: /.+@.+\..+/i }, uniqueness: { case_sensitive: false }

  class << self

    def facebook_login(auth)
      where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
        user.email = auth['info']['email']
        user.password = 123456
        user.name = auth['info']['name']
      end
    end

  end

  def cart
    orders.find_or_create_by(state: 'in_progress')
  end

end
