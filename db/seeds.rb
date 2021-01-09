# frozen_string_literal: true

5.times do
  Book.create({
                title: Faker::Book.title,
                author: Author.create({
                                        first_name: Faker::Name.first_name,
                                        last_name: Faker::Name.first_name
                                      })
              })
end
