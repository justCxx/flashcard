class Card < ActiveRecord::Base
  MAX_CORRECT_ANSWERS = 5
  MAX_INCORRECT_ANSWERS = 3
  MAX_LEVENSHTEIN_DISTANCE = 1

  belongs_to :deck

  validates :original_text, :translated_text, :review_date, presence: true
  validate :words_different
  validates_associated :deck

  before_validation :set_review_date, if: :new_record?

  has_attached_file :image, styles: { medium: "360x360", thumb: "100x100" },
                            default_url: "cards/missing/:style/missing.png"

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { in: 0..1.megabytes }

  def self.for_review
    cards = where("review_date < ?", DateTime.now)
    cards.offset(rand(cards.count))
  end

  def review(translated)
    typos = words_distanse(translated, original_text)

    if typos <= MAX_LEVENSHTEIN_DISTANCE
      handle_correct_answer
    else
      handle_incorrect_answer
    end

    { typos: typos, user_answer: normalize(translated).titleize }
  end

  protected

  def handle_correct_answer
    increment(:correct_answers) if correct_answers < MAX_CORRECT_ANSWERS
    update_attributes(incorrect_answers: 0)
    update_review_date
  end

  def handle_incorrect_answer
    decrement(:correct_answers) if correct_answers > 0
    increment(:incorrect_answers) if incorrect_answers < MAX_INCORRECT_ANSWERS
    save
  end

  def normalize(str)
    str.squish.mb_chars.downcase.to_s
  end

  def set_review_date
    self.review_date = DateTime.now
  end

  def update_review_date
    case correct_answers
    when 0
      offset = 0
    when 1
      offset = 12.hour
    when 2
      offset = 3.day
    when 3
      offset = 1.week
    when 4
      offset = 2.week
    else
      offset = 1.month
    end

    update_attributes(review_date: review_date + offset)
  end

  def words_different
    if normalize(original_text) == (translated_text)
      errors.add(:original_text, "can't equal translated text")
    end
  end

  def words_distanse(word1, word2)
    DamerauLevenshtein.distance(normalize(word1), normalize(word2))
  end
end
