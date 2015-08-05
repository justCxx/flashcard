class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :words_different

  before_validation :set_review_date, if: :new_record?

  protected

  def words_different
    if normalize(original_text) == normalize(translated_text)
      errors.add(:original_text, "can't equal translated text")
    end
  end

  def normalize(str)
    str.strip.mb_chars.downcase.to_s
  end

  def set_review_date
    self.review_date = Date.today + 3.days
  end
end
