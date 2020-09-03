class CourseBlueprint < Blueprinter::Base
  view :normal do
    fields :id, :title, :description, :slug
  end
end
