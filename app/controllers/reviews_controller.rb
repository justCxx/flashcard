class ReviewsController < ApplicationController
  def new
    @card = current_user.cards_for_review.first
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    if @card.review(review_params[:answer])
      flash[:success] = "Right! Next review: #{@card.review_date.localtime}"
    else
      flash[:danger] = "Wrong! Next review: #{@card.review_date.localtime}"
    end
    redirect_to root_url
  end

  protected

  def review_params
    params.require(:review).permit(:card_id, :answer)
  end
end
