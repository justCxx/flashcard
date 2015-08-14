require "rails_helper"
require "support/login_helper"

describe "Decks" do
  let!(:user) { FactoryGirl.create(:user, email: "f@b.ru") }
  let!(:user_with_decks) do
    FactoryGirl.create(:user_with_decks, email: "b@f.com", decks_count: 10)
  end

  before(:each) do
    login("f@b.ru", "foobar")
  end

  it "add new deck" do
    visit new_deck_path
    expect(current_path).to eq(new_deck_path)
  end
end
