# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:name) { |n| "name #{n}" }

    trait :song_cricket_game do
      interest_list { %w[song cricket game] }
    end

    trait :cricket do
      interest_list { %w[cricket] }
    end

    trait :song do
      interest_list { %w[song] }
    end

    trait :with_unavailable_interests do
      interest_list { %w[fosseball] }
    end

    trait :book_song do
      interest_list { %w[book song] }
    end

    trait :game do
      interest_list { %w[game] }
    end
  end
end
