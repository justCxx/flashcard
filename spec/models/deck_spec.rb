require "rails_helper"

describe Deck do
  let(:deck) { FactoryGirl.create(:deck, title: "MyDeck") }

  it "created a new" do
    expect(deck.title).to eq("MyDeck")
  end

  it "has no cards" do
    expect(deck.cards.count).to be 0
  end
end
