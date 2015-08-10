class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  validates :email, :password, presence: true
end
