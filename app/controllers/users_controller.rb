class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end