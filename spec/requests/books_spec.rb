# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET  /books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: '1984', author: 'George Orwell')
      FactoryBot.create(:book, title: 'The Time Machine', author: 'H.G Wells')

      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end

  describe 'POST  /books' do
    it 'create a new book' do
      expect do
        post '/api/v1/books', params: { title: 'Title', author: 'Author' }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE  /books/:id' do
    it 'deletes a book' do
      book = FactoryBot.create(:book, title: '1984', author: 'George Orwell')
      delete "/api/v1/books/#{book.id}"

      expect(response).to have_http_status(:ok)
    end
  end
end
