FactoryBot.define do
  factory :user, aliases: [:member] do
    sequence(:nickname) { |n| "テストユーザー#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
