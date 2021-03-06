class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  
  def index
    if logged_in?
      @quote = current_user.quotes.build 
      @quotes = current_user.quotes.order(id: :desc).page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    if logged_in?
    @quote = current_user.quotes.build 
    @quotes = @user.quotes.order(id: :desc).page(params[:page])
    counts(@user)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @quote = current_user.quotes.build 
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @quote = current_user.quotes.build 
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
