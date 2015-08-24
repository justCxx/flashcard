class ReviewsController < ApplicationController
  def new
    @card = current_user.cards_for_review.first
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    review = @card.review(review_params[:answer])

    if review[:success]
      flash[:success] = t("review_success",
                          original: @card.original_text,
                          translated: @card.translated_text,
                          user_answer: review_params[:answer],
                          typos: review[:typos],
                          next: @card.review_date.localtime
                         )
    else
      flash[:danger] = "#{t('review_wrong', next_review: @card.review_date)}"
    end
    redirect_to new_review_path
  end

  protected

  def review_params
    params.require(:review).permit(:card_id, :answer)
  end
end
