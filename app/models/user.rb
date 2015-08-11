class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :cards, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :crypted_password, presence: true
  validates :password, length: { minimum: 6 }, if: :new_record?
end
