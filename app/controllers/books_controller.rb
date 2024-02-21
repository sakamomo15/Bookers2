class BooksController < ApplicationController


  def create
    book = Book.new(book_params)
    book.user_id = current_user.id #bookのtableに必要なuser_idは入力してもらわないので、ここで定義
    book.save
    redirect_to book_path(book)
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(current_user.id)
    @book = Book.new
    @book_detail = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
