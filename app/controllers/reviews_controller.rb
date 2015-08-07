class ReviewsController < ApplicationController
  def index
    @card = Card.cards_for_review.first
  end

  def review_card
    @card = Card.find(review_params[:id])
    if @card.check_user_answer(params[:answer])
      flash[:succes] = "Правильно!"
    else
      flash[:danger] = "Неправильно!"
    end
    redirect_to root_url
  end

  protected

  def review_params
    params.require(:review).permit(:id, :answer)
  end
end
