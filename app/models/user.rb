class User < ActiveRecord::Base
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  belongs_to :default_deck, class_name: "Deck", foreign_key: "default_deck_id"

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: true
  validates :crypted_password, presence: true
  validates :password, length: { minimum: 6 }, if: :new_record?

  def cards_for_review
    if default_deck
      default_deck.cards.for_review
    else
      Card.where(deck_id: decks).for_review
    end
  end

  def has_linked_github?
    authentications.where(provider: "github").present?
  end
end
