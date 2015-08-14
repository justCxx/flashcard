class User < ActiveRecord::Base
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: true
  validates :crypted_password, presence: true
  validates :password, length: { minimum: 6 }, if: :new_record?

  def default_deck
    if default_deck_id
      decks.find(default_deck_id)
    else
      decks.offset(rand(decks.count)).first
    end
  end

  def has_linked_github?
    authentications.where(provider: "github").present?
  end
end
