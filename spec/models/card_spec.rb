require "rails_helper"

describe Card do
  context "initialize" do
    context "defaults" do
      let(:card) { create(:card) }
      it { expect(card.e_factor).to be 2.5 }
      it { expect(card.interval).to be 0 }
      it { expect(card.quality).to be 0 }
      it { expect(card.repetitions).to be 0 }
    end

    context "invalid" do
      let(:card) { build(:card, original_text: "foo", translated_text: "foo") }
      it { expect(card).to be_invalid }
    end
  end

  context "check input" do
    let(:card) { create(:card, original_text: "Bueno") }

    it "right answer" do
      expect(card.review("bueno", 0)[:typos]).to be 0
    end

    it "right answer case insensitive" do
      expect(card.review("BuENo", 0)[:typos]).to be 0
    end

    it "right answer with trailing whitespaces" do
      expect(card.review("  bueno  ", 0)[:typos]).to be 0
    end

    it "right answer with typos" do
      expect(card.review("byeno", 0)[:typos]).to be 1
    end

    it "wrong answer" do
      expect(card.review("malo", 0)[:typos]).to be > 1
    end
  end

  describe "#review" do
    let(:time_now) { Time.parse("Aug 25 2015") }

    before(:each) do
      DateTime.stub(:now).and_return(time_now)
      card.review(card.original_text, 4)
    end

    context "the first right review" do
      let(:card) { create(:card) }
      it { expect(card.review_date).to eq time_now + 1.day }
    end

    context "the second right review" do
      let(:card) { create(:card, interval: 1, repetitions: 1) }
      it { expect(card.review_date).to eq time_now + 6.day }
    end

    context "the third right review" do
      let(:card) { create(:card, interval: 6, repetitions: 2) }
      it { expect(card.review_date).to eq time_now + (2.5 * 6).day }
    end

    context "the fourth right review" do
      let(:card) { create(:card, interval: 15, repetitions: 3) }
      it { expect(card.review_date).to eq time_now + (2.5 * 15).ceil.day }
    end

    context "the fifth right review" do
      let(:card) { create(:card, interval: 37, repetitions: 4) }
      it { expect(card.review_date).to eq time_now + (2.5 * 37).ceil.day }
    end
  end
end
