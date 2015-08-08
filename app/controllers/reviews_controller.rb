class ReviewsController < ApplicationController
  def index
    @card = Card.for_review.first
  end

  def review_card
    @card = Card.find(review_params[:card_id])
    if @card.check_user_answer(params[:answer])
      flash[:succes] = "Правильно!"
    else
      flash[:danger] = "Неправильно!"
    end
    redirect_to root_url
  end

  protected

  def review_params
    params.permit(:card_id, :answer)
  end
end
