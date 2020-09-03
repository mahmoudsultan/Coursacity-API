require 'faker'

10.times do
  programing_language_name = Faker::ProgrammingLanguage.name
  title = "Learn #{programing_language_name}"
  description = Faker::Lorem.paragraph
  slug = "#{programing_language_name}-123"

  course = Course.create! title: title, description: description, slug: slug
  course.photo.attach(io: File.open(Rails.root.join('public', 'default_course_image.jpg')), filename: "#{programing_language_name}.jpg")
end

