# frozen_string_literal: true

5.times do
  Book.create({
                title: Faker::Book.title,
                author: Faker::Book.title
              })
end
