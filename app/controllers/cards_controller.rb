class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    @card.review_date = DateTime.now.to_date
    @card.save
    redirect_to Card
  end

  def update
  end

  def destroy
  end

  private

    def card_params
      params.require(:card).permit(:original_text, :translated_text)
    end
end
