class UsersController < ApplicationController
before_action :move_to_signed_in, only: [:index, :show, :edit]
before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book =  @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    
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
