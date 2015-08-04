class Card < ActiveRecord::Base
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :words_different

  def words_different
    if original_text.mb_chars.downcase.to_s == translated_text.mb_chars.downcase.to_s
      errors.add(:original_text, "can't equal translated text")
    end
  end
end
