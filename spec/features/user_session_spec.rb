require "rails_helper"
require "support/login_helper"

describe "User session" do
  let!(:user) { FactoryGirl.create(:user, email: "f@b.ru") }
  let!(:user_with_decks) do
    FactoryGirl.create(:user_with_decks, email: "b@f.com", decks_count: 10)
  end

  context "when user not logged" do
    it "login form shown" do
      visit root_path
      expect(current_path).to eq(login_path)
    end

    it "decks page redirect to login form" do
      visit decks_path
      expect(current_path).to eq(login_path)
    end
  end

  context "when login failed" do
    it "again login form shown" do
      login("john@smith.com", "foobar")
      expect(current_path).to eq(login_path)
    end
  end

  context "when user authorized" do
    before(:each) do
      login("f@b.ru", "foobar")
    end

    it "redirect to root after login" do
      expect(current_path).to eq(root_path)
    end

    it "see decks page" do
      visit decks_path
      expect(current_path).to eq(decks_path)
    end

    it "logout" do
      visit logout_path
      expect(current_path).to eq(login_path)
    end
  end

  context "when another user authorized" do
    before(:each) do
      login("b@f.com", "foobar")
    end

    it "sees only their own decks" do
      visit decks_path
      expect(page).to have_content("Колоды (10)")
    end
  end
end
