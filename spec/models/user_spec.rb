require "rails_helper"

describe User do
  let(:user) { FactoryGirl.create(:user) }

  it "created a new" do
    expect(user.email).to eq "foo@bar.com"
  end

  it "has no decks" do
    expect(user.decks.count).to be 0
  end

  context "email notification" do
    let!(:user) { create(:user_with_cards, cards_count: 1) }

    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      User.notify_review
    end

    it "should send an email" do
      expect(ActionMailer::Base.deliveries.count).to be 1
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end
end
