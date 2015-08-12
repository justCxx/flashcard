FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "foobar"

    factory :user_with_cards do
      transient do
        cards_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:card, evaluator.cards_count, user: user)
      end
    end
  end
end
