FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "foobar"
    locale "en"

    factory :user_with_decks do
      transient do
        decks_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:deck, evaluator.decks_count, user: user)
      end
    end

    factory :user_with_cards do
      transient do
        cards_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:deck_with_cards, 1, cards_count: evaluator.cards_count,
                                         user: user)
      end
    end
  end
end
