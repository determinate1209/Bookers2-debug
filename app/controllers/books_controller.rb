class BooksController < ApplicationController
before_action :move_to_signed_in, only: [:edit, :index, :show]
before_action :correct_user, only: [:edit, :update]

  def show
    @see = See.find_by(ip: request.remote_ip) 
    if @see
      @books = Book.find(params[:id])
      @user = @books.user
      @book = Book.new
      @book_comment = BookComment.new
    else
      @books = Book.find(params[:id])
      @user = @books.user
      @book = Book.new
      @book_comment = BookComment.new
      See.create(ip: request.remote_ip)
    end
    
  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b| 
      b.favorites.where(created_at: from...to).size <=> 
      a.favorites.where(created_at: from...to).size
    }

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
