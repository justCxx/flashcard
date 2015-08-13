class Card < ActiveRecord::Base
  belongs_to :user

  validates :original_text, :translated_text, :review_date, presence: true
  validate :words_different
  validates_associated :user

  before_validation :set_review_date, if: :new_record?

  has_attached_file :image, styles: { medium: "360x360", thumb: "100x100" }

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { in: 0..1.megabytes }

  def self.for_review
    cards = where("review_date < ?", Date.today)
    cards.offset(rand(cards.count))
  end

  def review(translated)
    if words_equal?(translated, original_text)
      update_attributes(review_date: review_date + 3)
    else
      false
    end
  end

  protected

  def normalize(str)
    str.squish.mb_chars.downcase.to_s
  end

  def set_review_date
    self.review_date = Date.today + 3.days
  end

  def words_different
    if words_equal?(original_text, translated_text)
      errors.add(:original_text, "can't equal translated text")
    end
  end

  def words_equal?(word1, word2)
    normalize(word1) == normalize(word2)
  end
end
