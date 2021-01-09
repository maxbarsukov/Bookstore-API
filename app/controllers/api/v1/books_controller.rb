# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Loaded books', data: books }, status: :ok
      end

      def show
        book = Book.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Loaded book', data: book }, status: :ok
      end

      def create
        author = Author.find_or_create_by(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
        if book.save
          render json: { status: 'SUCCESS', message: 'Saved book', data: book }, status: :created
        else
          render json: { status: 'ERROR',
                         message: 'Book not saved',
                         data: book.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        book = Book.find(params[:id])
        book.destroy
        render json: { status: 'SUCCESS', message: 'Deleted book', data: book }, status: :ok
      rescue ActiveRecord::RecordNotDestroyed
        render json: { status: 'ERROR',
                       message: 'Book not destroyed',
                       data: book.errors },
               status: :unprocessable_entity
      end

      def update
        book = Book.update(params[:id], book_params)
        if book.save
          render json: { status: 'SUCCESS', message: 'Updated book', data: book }, status: :ok
        else
          render json: { status: 'ERROR',
                         message: 'Book not updated',
                         data: book.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def author_params
        params.permit(:first_name, :last_name)
      end

      def book_params
        params.permit(:title, :author)
      end
    end
  end
end
