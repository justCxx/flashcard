require "rails_helper"
require "support/login_helper"

describe "Card features" do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) { login("foo@bar.com", "foobar") }

  it "creating new cards and deck" do
    visit new_card_path

    fill_in("deck_title", with: "NewDeck")
    fill_in("card_original_text", with: "foo")
    fill_in("card_translated_text", with: "bar")
    click_button "Create Card"

    deck = user.decks.first
    expect(deck.title).to eq("NewDeck")
    expect(deck.cards.first.original_text).to eq("foo")
    expect(deck.cards.first.translated_text).to eq("bar")
  end

  context "when exist deck and card" do
    let!(:deck) { FactoryGirl.create(:deck, user: user) }
    let!(:card) { FactoryGirl.create(:card, deck: deck) }

    it "edit card translated" do
      visit edit_card_path(card)
      fill_in("card_translated_text", with: "new text")
      click_button "Update Card"
      expect(deck.cards.first.translated_text).to eq "new text"
    end

    it "remove card" do
      visit cards_path(deck_id: deck.id)
      first(:link, "Destroy").click
      expect(deck.cards.count).to be 0
    end
  end
end
