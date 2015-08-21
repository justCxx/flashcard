require "rails_helper"
require "support/login_helper"

describe "Deck features" do
  let!(:deck) { FactoryGirl.create(:deck) }

  before(:each) { login("foo@bar.com", "foobar") }

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
    expect(current_path).to eq deck_path(deck)
  end

  it "update deck title" do
    visit edit_deck_path(deck)
    fill_in("deck_title", with: "TestDeck")
    click_button "Update Deck"
    expect(deck.user.decks.first.title).to eq "TestDeck"
  end

  it "remove deck" do
    visit decks_path
    click_link "Удалить"
    expect(page).to have_content("Колоды (0)")
  end
end
