FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "foobar"

    factory :user_with_decks do
      transient do
        decks_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:deck, evaluator.decks_count, user: user)
      end
    end
  end
end
