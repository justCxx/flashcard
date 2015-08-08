class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :words_different

  before_validation :set_review_date, if: :new_record?

  scope :for_review, -> {
    cards = where("review_date < ?", Date.today)
    cards.offset(rand(cards.count))
  }

  def check_user_answer(answer)
    if words_equal?(answer, original_text)
      update_attributes(review_date: review_date + 3)
    else
      false
    end
  end

  protected

  def normalize(str)
    str.strip.mb_chars.downcase.to_s
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
