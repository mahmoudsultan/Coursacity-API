require 'faker'

1000.times do
  programing_language_name = Faker::ProgrammingLanguage.name
  title = "Learn #{programing_language_name}"
  description = Faker::Lorem.paragraph
  slug = "#{programing_language_name}-#{(rand * 1000).ceil}"

  course = Course.create! title: title, description: description, slug: slug
  course.photo.attach(io: File.open(Rails.root.join('public', 'default_course_image.jpg')), filename: "#{programing_language_name}.jpg")
  course.preprocess_photo_variant
end

