# frozen_string_literal: true

class Course < ApplicationRecord
  has_one_attached :photo

  default_scope { order(created_at: :desc) }

  validates :title, presence: true, length: { in: 3..100 }
  validates :description, presence: true
  validates :slug, presence: true, length: { in: 3..100 }, uniqueness: { case_sensitive: false }

  class << self
    def search(query)
      where('lower(title) LIKE :query', query: "%#{sanitize_sql_like(query.downcase)}%")
    end
  end
end
