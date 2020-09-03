# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, presence: true, length: { in: 3..100 }
  validates :description, presence: true
  validates :slug, presence: true, length: { in: 3..100 }
end
