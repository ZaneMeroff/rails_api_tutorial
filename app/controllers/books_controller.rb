class BooksController < ApplicationController
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def index
    render json: Book.all
  end

  def create
    # book = Book.new(author: params[:author], title: params[:title])
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created #201
    else
      render json: book.errors, status: :unprocessable_entity #422
    end
  end

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content #204
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end

  def not_destroyed
    render json: {}, status: :unprocessable_entity
  end
end
