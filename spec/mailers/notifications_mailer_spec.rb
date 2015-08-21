require "rails_helper"

describe NotificationsMailer do
  let!(:user) { create(:user_with_cards, cards_count: 1) }

  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    NotificationsMailer.pending_cards(user).deliver_now
  end

  it "should send an email" do
    expect(ActionMailer::Base.deliveries.count).to be 1
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end
