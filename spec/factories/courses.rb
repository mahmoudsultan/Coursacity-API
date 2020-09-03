# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    trait :valid do
      title { 'Course Title' }
      description { 'Course Description' }
      sequence(:slug) { |n| "slug-#{n}" }
    end

    trait :invalid do
      title { '' }
      description { '' }
      slug { '' }
    end
  end
end
