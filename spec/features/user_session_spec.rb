require "rails_helper"
require "support/login_helper"

describe "User session" do
  let!(:user) { FactoryGirl.create(:user, email: "f@b.ru", password: "foobar") }

  context "when user not logged" do
    it "login form shown" do
      visit root_path
      expect(page).to have_content("First login to access this page.")
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
  end
end
