class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def create
    @user = current_user
    @book = Book.new
    @books = Book.all

    @book_data = Book.new(book_params)
    @book_data.user_id = current_user.id #bookのtableに必要なuser_idは入力してもらわないので、ここで定義

    if @book_data.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_data.id)
    else
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @book_data = Book.new ##createのrenderのために@book_data必須だが、indexではとりあえずBook.newを定義
  end

  def show
    @user = User.find(current_user.id)
    @book = Book.new
    @book_data = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    @book = Book.new

    @book_data = Book.find(params[:id])
    if @book_data.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book_data.id)
    else
      render :show
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user = User.find(book.user_id)
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
