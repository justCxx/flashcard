class Card < ActiveRecord::Base
  MAX_LEVENSHTEIN_DISTANCE = 1

  belongs_to :deck

  validates :original_text, :translated_text, :review_date, presence: true
  validate :words_different
  validates_associated :deck

  after_initialize :set_default_date, if: :new_record?

  has_attached_file :image, styles: { medium: "360x360", thumb: "100x100" },
                            default_url: "cards/missing/:style/missing.png"

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { in: 0..1.megabytes }

  def self.for_review
    cards = where("review_date < ?", DateTime.now)
    cards.offset(rand(cards.count))
  end

  def review(translated, quality)
    typos = words_distanse(translated, original_text)
    success = typos <= MAX_LEVENSHTEIN_DISTANCE
    update_review_date(success ? quality : 0)
    { success: success, typos: typos }
  end

  protected

  def update_review_date(quality)
    repetition = SuperMemo2.repetition(e_factor, interval, quality, repetitions)
    repetition[:review_date] = DateTime.now + repetition[:interval]
    update_attributes(repetition)
  end

  def words_distanse(word1, word2)
    DamerauLevenshtein.distance(normalize(word1), normalize(word2))
  end

  private

  def normalize(str)
    str.squish.mb_chars.downcase.to_s
  end

  def set_default_date
    self.review_date = DateTime.now
  end

  def words_different
    if normalize(original_text) == (translated_text)
      errors.add(:original_text, "can't equal translated text")
    end
  end
end
