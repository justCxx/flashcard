class ReviewsController < ApplicationController
  def new
    @card = current_user.cards_for_review.first
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review = @card.review(review_params[:answer])

    if review[:success]
      flash[:success] = "Right! Original: #{@card.original_text}, " \
                        "translated: #{@card.translated_text}. " \
                        "Your answer: #{review_params[:answer]}. " \
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
