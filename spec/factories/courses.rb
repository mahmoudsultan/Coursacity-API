# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    trait :valid do
      title { 'Course Title' }
      description { 'Course Description' }
      slug { 'slug-123' }
    end

    trait :invalid do
      title { '' }
      description { '' }
      slug { '' }
    end
  end
end
