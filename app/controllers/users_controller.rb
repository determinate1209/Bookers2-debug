class UsersController < ApplicationController
before_action :move_to_signed_in, only: [:index, :show, :edit]
before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @two_days_ago_book = @books.created_two_days_ago
    @three_days_ago_book = @books.created_three_days_ago
    @four_days_ago_book = @books.created_four_days_ago
    @five_days_ago_book = @books.created_five_days_ago
    @six_days_ago_book = @books.created_six_days_ago
    
    
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    
    redirect_to(user_path(current_user)) unless @user == current_user
  end
  
  def move_to_signed_in
    unless user_signed_in?
      
      redirect_to  '/users/sign_in'
    end
  end
end
