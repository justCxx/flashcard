FactoryGirl.define do
  factory :card do
    original_text "foo"
    translated_text "bar"
    deck
  end
end
