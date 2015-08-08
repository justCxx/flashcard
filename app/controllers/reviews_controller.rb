class ReviewsController < ApplicationController
  def index
    @card = Card.for_review.first
  end

  def create
    @card = Card.find(params[:card_id])
    if @card.check_user_answer(review_params[:answer])
      flash[:succes] = "Правильно!"
    else
      flash[:danger] = "Неправильно!"
    end
    redirect_to root_url
  end

  protected

  def review_params
    params.require(:review).permit(:answer)
  end
end
