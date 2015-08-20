class ReviewsController < ApplicationController
  def new
    @card = current_user.cards_for_review.first
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review = @card.review(review_params[:answer])

    case review[:typos]
    when 0
      flash[:success] = "Right! Next review: #{@card.review_date.localtime}"
    when 1..Card::MAX_LEVENSHTEIN_DISTANCE
      flash[:success] = "Almost correct. Original: #{@card.original_text}, " \
                        "translated: #{@card.translated_text}. " \
                        "Your answer: #{review[:user_answer]}. " \
                        "Typos: #{review[:typos]}. " \
                        "Next review: #{@card.review_date.localtime}"
    else
      flash[:danger] = "Wrong! Next review: #{@card.review_date.localtime}"
    end
    redirect_to new_review_path
  end

  protected

  def review_params
    params.require(:review).permit(:card_id, :answer)
  end
end
