# frozen_string_literal: true

FactoryBot.define do
  factory :gift do
    trait :cricket do
      name { "cricket bat" }
      category_list { %w[cricket] }
      after(:create) { |gift| gift.update(category_list: %w[cricket]) }
    end

    trait :song do
      name { "Gaana.com" }
      category_list { %w[song music] }
    end

    trait :game do
      name { "Xbox" }
      category_list { %w[game] }
    end

    trait :book do
      name { "Learn Ruby Programming" }
      category_list { %w[book programming] }
    end
  end
end
