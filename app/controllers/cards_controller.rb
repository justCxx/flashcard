class CardsController < ApplicationController
  before_action :set_card, except: [:index, :new, :create]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

  def set_card
    @card = current_user.cards.find(params[:id])
  end
end
