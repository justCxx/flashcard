require "rails_helper"
require "support/login_helper"

describe "Review features" do
  let!(:deck) { FactoryGirl.create(:deck) }

  context "when not available cards for review" do
    it "no cards for review" do
      default_login
      visit new_review_path
      expect(page).to have_content("Нет карточек для просмотра")
    end
  end

  context "when available cards for review" do
    let!(:review) { create(:card, original_text: "Bueno", deck: deck) }

    before(:each) do
      default_login
      visit new_review_path
    end

    it "input right answer" do
      fill_in("Answer", with: "bueno")
      click_on "Проверить"
      expect(page).to have_content "Right!"
    end

    it "input wrong answer" do
      fill_in("Answer", with: "malo")
      click_on "Проверить"
      expect(page).to have_content "Wrong!"
    end
  end
end
