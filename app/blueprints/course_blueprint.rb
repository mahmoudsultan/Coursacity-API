# frozen_string_literal: true

class CourseBlueprint < Blueprinter::Base
  view :normal do
    fields :id, :title, :description, :slug
    field :photo do |course|
      Rails.application.routes.url_helpers.rails_blob_path(course.photo, only_path: true) if course.photo.attached?

      ''
    end
  end
end
