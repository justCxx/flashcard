require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it "check the user created" do
    expect(user.email).to eq "foo@bar.com"
  end
end
