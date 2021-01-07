# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Loaded books', data: books }, status: :ok
      end
    end
  end
end
