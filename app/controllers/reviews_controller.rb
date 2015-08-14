class ReviewsController < ApplicationController
  def new
    if current_user.default_deck
      @card = current_user.default_deck.cards.for_review.first
    elsif current_user.decks.count > 0
      decks = current_user.decks
      @card = decks.offset(rand(decks.count)).first.cards.for_review
    end
  end

  def create
    @card = Card.find(review_params[:card_id])
    if @card.review(review_params[:answer])
      flash[:success] = "Правильно!"
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
