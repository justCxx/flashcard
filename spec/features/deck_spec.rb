require "rails_helper"
require "support/login_helper"

describe "Decks" do
  let!(:deck) do
    FactoryGirl.create(:deck)
  end

  before(:each) do
    login("foo@bar.com", "foobar")
  end

  it "titled deck added" do
    deck_count = deck.user.decks.count
    visit new_deck_path
    fill_in("deck_title", with: "MyDeck")
    click_button "Create Deck"
    expect(deck.user.decks.count).to be (deck_count + 1)
  end

  it "untitled deck is no added" do
    deck_count = deck.user.decks.count
    visit new_deck_path
    fill_in("deck_title", with: "")
    click_button "Create Deck"
    expect(deck.user.decks.count).to be (deck_count)
  end

  it "show cards in deck" do
    visit deck_path(deck)
    expect(current_path).to eq deck_cards_path(deck)
  end

  it "update deck title" do
    visit edit_deck_path(deck)
    fill_in("deck_title", with: "TestDeck")
    click_button "Update Deck"
    expect(deck.user.decks.first.title).to eq "TestDeck"
  end
end
