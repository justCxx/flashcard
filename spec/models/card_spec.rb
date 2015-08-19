require "rails_helper"

describe Card do
  context "initialize" do
    let(:invalid) { build(:card, original_text: "foo", translated_text: "foo") }

    it "invalid card" do
      expect(invalid).to be_invalid
    end
  end

  context "check input" do
    let(:card) { FactoryGirl.create(:card, original_text: "Bueno") }
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
  end

  describe "#handle_correct_answer" do
    before(:each) do
      @original_date = card.review_date
      card.review(card.original_text)
    end

    context "after the first right review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 0) }
      it { expect(card.review_date).to eq @original_date + 12.hour }
    end

    context "after the second right review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 1) }
      it { expect(card.review_date).to eq @original_date + 3.day }
    end

    context "after the third right review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 2) }
      it { expect(card.review_date).to eq @original_date + 1.week }
    end

    context "after the fourth right review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 3) }
      it { expect(card.review_date).to eq @original_date + 2.week }
    end

    context "after the fifth right review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 4) }
      it { expect(card.review_date).to eq @original_date + 1.month }
    end
  end

  describe "#handle_incorrect_answer" do
    before(:each) do
      @original_date = card.review_date
      card.review("#{card.original_text}foo")
    end

    context "after the first wrong review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 3) }
      it { expect(card.correct_answers).to eq 2 }
    end

    context "after the second wrong review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 2) }
      it { expect(card.correct_answers).to eq 1 }
    end

    context "after the third wrong review" do
      let(:card) { FactoryGirl.create(:card, correct_answers: 1) }
      it { expect(card.correct_answers).to eq 0 }
    end
  end
end
