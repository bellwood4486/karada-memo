FactoryBot.define do
  factory :body do
    sequence(:nickname) { |n| "からだ#{n}" }
    association :family

    trait :with_notes do
      transient do
        note_count 5
      end

      after(:build) do |body, evaluator|
        body.notes << build_list(:note, evaluator.note_count)
      end
    end
  end
end
