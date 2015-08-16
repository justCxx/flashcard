class CardsController < ApplicationController
  before_action :set_card, except: [:index, :new, :create]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = Card.new
    @deck = @card.build_deck
    @decks = current_user.decks
  end

  def edit
    @decks = current_user.decks
  end

  def create
    @deck = new_deck
    @card = @deck.cards.new(card_params)
    if @card.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params) && @card.update_attributes(deck: new_deck)
      redirect_to deck_path(@card.deck)
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to :back
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text,
                                 :review_date, :image, :deck_id)
  end

  def deck_params
    params.require(:deck).permit(:title)
  end

  def new_deck
    @decks = current_user.decks
    if !deck_params[:title].empty?
      @decks.create(title: deck_params[:title])
    elsif !card_params[:deck_id].empty?
      @decks.find(card_params[:deck_id])
    end
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
