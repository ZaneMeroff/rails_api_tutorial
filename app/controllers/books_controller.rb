class BooksController < ApplicationController
  def index
    redner json: Book.all
  end
end
