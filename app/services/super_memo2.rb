# This class implement a _SuperMemo2_ algorithm.
# See more: http://www.supermemo.com/english/ol/sm2.htm
#
# Algorithm _SM-2_ used in the computer-based variant of the SuperMemo method
# and involving the calculation of easiness factors for particular items:
#
# 1. Split the knowledge into smallest possible items.
# 2. With all items associate an E-Factor equal to 2.5.
# 3. Repeat items using the following intervals:
#     I(1) = 1
#     I(2) = 6
#     for n > 2: I(n) = I(n-1) * EF
#
#    where:
#    *I*(*n*) - inter-repetition interval after the n-th repetition (in days),
#    *EF* - E-Factor of a given item
#    If interval is a fraction, round it up to the nearest integer.
# 4. After each repetition assess the quality of repetition response in 0-5
#    grade scale:
#     5 - perfect response
#     4 - correct response after a hesitation
#     3 - correct response recalled with serious difficulty
#     2 - incorrect response; where the correct one seemed easy to recall
#     1 - incorrect response; the correct one remembered
#     0 - complete blackout.
# 5. After each repetition modify the E-Factor of the recently repeated item
#    according to the formula:
#     E-Factror = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
#    where:
#    *E-Factor* - new value of the E-Factor,
#    *EF* - old value of the E-Factor,
#    *q* - quality of the response in the 0-5 grade scale.
#    If *EF* is less than 1.3 then let EF be 1.3.
# 6. If the quality response was lower than 3 then start repetitions for the
#    item from the beginning without changing the E-Factor (i.e. use intervals
#    I(1), I(2) etc. as if the item was memorized anew).
# 7. After each repetition session of a given day repeat again all items that
#    scored below four in the quality assessment. Continue the repetitions until
#    all of these items score at least fou
class SuperMemo2
  MIN_E_FACTOR = 1.3
  MIN_QUALITY = 3

  # Return repetition result
  def self.repetition(e_factor, interval, quality, repetitions)
    repetitions = reduce_repetitions(repetitions, quality)
    {
      e_factor: e_factor(e_factor, quality),
      interval: interval(e_factor, interval, repetitions).days,
      quality: quality,
      repetitions: repetitions + 1
    }
  end

  # Return interval unto the next repetition (see p.3 of class description).
  def self.interval(e_factor, interval, repetitions)
    case repetitions
    when 0 then 1
    when 1 then 6
    else
      (interval * e_factor).ceil
    end
  end

  # Return E-Factor according to the formula (see p.5 of class description).
  def self.e_factor(e_factor, quality)
    ef = e_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    [MIN_E_FACTOR, ef].max
  end

  # Return count of repetitions (see p.3 of class description).
  def self.reduce_repetitions(repetitions, quality)
    quality < MIN_QUALITY ? 0 : repetitions
  end
end
