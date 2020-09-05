# frozen_string_literal: true

class Course < ApplicationRecord
  after_create_commit :preprocess_photo_variant

  has_one_attached :photo

  default_scope { order(created_at: :desc) }

  validates :title, presence: true, length: { in: 3..100 }
  validates :description, presence: true
  validates :slug, presence: true, length: { in: 3..100 }, uniqueness: { case_sensitive: false }

  def preprocess_photo_variant
    self.photo.variant(resize: "320x240").processed if self.photo.attached?
  end

  class << self
    def search(query)
      where('lower(title) LIKE :query', query: "%#{sanitize_sql_like(query.downcase)}%")
    end
  end
end
