class User < ActiveRecord::Base
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  belongs_to :default_deck, class_name: "Deck", foreign_key: "default_deck_id"

  authenticates_with_sorcery!
  accepts_nested_attributes_for :authentications

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :new_record?

  def cards
    Card.where(deck_id: decks)
  end

  def cards_for_review
    default_deck ? default_deck.cards.for_review : cards.for_review
  end

  def self.notify_review
    User.all.each do |user|
      NotificationsMailer.pending_cards(user).deliver_later
    end
  end
end
