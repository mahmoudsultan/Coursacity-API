class CourseBlueprint < Blueprinter::Base
  view :normal do
    fields :id, :title, :description, :slug
    field :photo do |course|
      if course.photo.attached?
        Rails.application.routes.url_helpers.rails_blob_path(course.photo, only_path: true)
      end

      ''
    end
  end
end
