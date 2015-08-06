class WelcomeController < ApplicationController
  def index
    show_card_for_review
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

  def show_card_for_review
    @card = Card.cards_for_review.first
  end

  def review_params
    params.require(:card).permit(:id)
  end

end
