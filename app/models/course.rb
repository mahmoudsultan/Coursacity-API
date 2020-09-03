# frozen_string_literal: true

class Course < ApplicationRecord
  has_one_attached :photo

  default_scope { order(created_at: :desc) }

  validates :title, presence: true, length: { in: 3..100 }
  validates :description, presence: true
  validates :slug, presence: true, length: { in: 3..100 }
end
