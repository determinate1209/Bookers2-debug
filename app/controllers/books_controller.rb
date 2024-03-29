class BooksController < ApplicationController
before_action :move_to_signed_in, only: [:edit, :index, :show]
before_action :correct_user, only: [:edit, :update]

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
    @book_comment = BookComment.new
    
    
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
  
  def move_to_signed_in
    unless user_signed_in?
      
      redirect_to  '/users/sign_in'
    end
  end
  
  
end
