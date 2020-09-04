# frozen_string_literal: true

class CourseBlueprint < Blueprinter::Base
  fields :id, :title, :description, :slug

  view :normal do
    field :photo do |course|
      if course.photo.attached?
        # Rails.application.routes.url_helpers.rails_blob_path(course.photo, only_path: true)
        Rails.application.routes.url_helpers.rails_representation_url(course.photo.variant(resize: "320x240"), only_path: true)
      else
        ''
      end
    end
  end

  view :detailed do
    field :photo do |course|
      if course.photo.attached?
        Rails.application.routes.url_helpers.rails_blob_path(course.photo, only_path: true)
      else
        ''
      end
    end
  end
end
