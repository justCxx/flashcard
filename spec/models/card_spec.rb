require "rails_helper"

RSpec.describe Card, type: :model do
  let(:card) { FactoryGirl.create(:card, original_text: "Bueno") }
  let(:invalid) { FactoryGirl.build(:card, translated_text: "foo") }

  it "card have ref to deck" do
    expect(card.attributes).to include("deck_id")
  end

  it "invalid factory" do
    expect(invalid).to be_invalid
  end

  it "right answer" do
    expect(card.review("bueno")).to be true
  end

  it "right answer case insensitive" do
    expect(card.review("BuENo")).to be true
  end

  it "right answer with trailing whitespaces" do
    expect(card.review("  bueno  ")).to be true
  end

  it "wrong answer" do
    expect(card.review("malo")).to be false
  end

  it "review date" do
    expect(card.review_date).to eq Date.today + 3
  end

  it "review date after card review" do
    review_date = card.review_date
    card.review("bueno")
    expect(card.review_date).to eq review_date + 3
  end
end
