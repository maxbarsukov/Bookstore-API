# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  let!(:first_author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell') }
  let!(:second_author) { FactoryBot.create(:author, first_name: 'Herbert George', last_name: 'Wells') }

  describe 'GET  /books' do
    before do
      FactoryBot.create(:book, title: '1984', author: first_author)
      FactoryBot.create(:book, title: 'The Time Machine', author: second_author)
    end

    it 'returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].size).to eq(2)
    end
  end

  describe 'POST  /books' do
    it 'create a new book' do
      expect do
        post '/api/v1/books', params: {
          title: 'Title',
          author: {
            first_name: 'FName',
            last_name: 'LName'
          }
        }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE  /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: '1984', author: first_author) }

    it 'deletes a book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:ok)
    end
  end
end
