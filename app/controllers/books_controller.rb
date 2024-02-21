class BooksController < ApplicationController


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
    @book_data = Book.new(book_params)
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
    @user = User.find(current_user.id)
    @book = Book.new
    
    @book_detail = Book.find(params[:id])
    if @book_detail.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book_detail.id)
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
    params.require(:book).permit(:title, :opinion)
  end
end
