class ReviewsController < ApplicationController
  def new
    @card = Card.for_review.first
  end

  def create
    @card = Card.find(review_params[:card_id])
    if @card.check_user_answer(review_params[:answer])
      flash[:succes] = "Правильно!"
    else
      flash[:danger] = "Неправильно!"
    end
    redirect_to root_url
  end

  protected

  def review_params
    params.require(:review).permit(:card_id, :answer)
  end
end
