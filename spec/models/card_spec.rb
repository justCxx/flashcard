require "rails_helper"

describe Card do
  let(:card) { FactoryGirl.create(:card, original_text: "Bueno") }

  it "check the right answer" do
    expect(card.review("bueno")).to be true
  end

  it "check the right answer case insensitive" do
    expect(card.review("BuENo")).to be true
  end

  it "check the right answer with trailing whitespaces" do
    expect(card.review("  bueno  ")).to be true
  end

  it "check the wrong answer" do
    expect(card.review("malo")).to be false
  end

  it "check the review date" do
    expect(card.review_date).to eq Date.today + 3
  end

  it "check the review date after review card" do
    review_date = card.review_date
    card.review("bueno")
    expect(card.review_date).to eq review_date + 3
  end
end
