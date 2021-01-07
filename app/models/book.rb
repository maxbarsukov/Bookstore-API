class Book < ApplicationRecord
  validates :title, :author, presence: true, length: { minimum: 1 }
end
