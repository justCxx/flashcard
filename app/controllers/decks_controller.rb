class DecksController < ApplicationController
  before_action :set_deck, except: [:index, :new, :create]

  def index
    @decks = current_user.decks
  end

  def show
    redirect_to deck_cards_path(@deck)
  end

  def new
    @deck = Deck.new
  end

  def edit
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  def set_default
    current_user.update_attributes(default_deck_id: params[:id])
    redirect_to profile_path
  end

  private

  def deck_params
    params.require(:deck).permit(:title)
  end

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end
end
