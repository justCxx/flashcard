require "rails_helper"

describe "Card review" do
  let(:review) { FactoryGirl.create(:card, original_text: "Bueno") }

  context "when not available cards for review" do
    it "no cards for review" do
      visit new_review_path
      expect(page).to have_content("Нет карточек для просмотра")
    end
  end

  context "when available cards for review" do
    before(:each) do
      card = review
      card.update_attributes(review_date: card.review_date - 5)
      visit new_review_path
    end

    it "input right answer" do
      fill_in("Answer", with: "bueno")
      click_on "Проверить"
      expect(page).to have_content "Правильно!"
    end

    it "input wrong answer" do
      fill_in("Answer", with: "malo")
      click_on "Проверить"
      expect(page).to have_content "Неправильно!"
    end
  end
end
