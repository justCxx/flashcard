require "rails_helper"
require "support/login_helper"

describe "User session" do
  let!(:user) { FactoryGirl.create(:user, email: "f@b.ru") }
  let!(:user_with_cards) do
    FactoryGirl.create(:user_with_cards, email: "b@f.com", cards_count: 10)
  end

  context "when user not logged" do
    it "login form shown" do
      visit root_path
      expect(page).to have_content("First login to access this page!")
    end
  end

  context "when user authorized" do
    before(:each) do
      login("f@b.ru", "foobar")
    end

    it "reviews page shown" do
      visit root_path
      expect(page).to have_content("Нет карточек для просмотра")
    end

    it "no cards" do
      visit cards_path
      expect(page).to have_content("Все карточки 0")
    end
  end

  context "when another user authorized" do
    before(:each) do
      login("b@f.com", "foobar")
    end

    it "sees only their own cards" do
      visit cards_path
      expect(page).to have_content("Все карточки 10")
    end
  end
end
