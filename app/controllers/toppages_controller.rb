class ToppagesController < ApplicationController
  def index
     
    if logged_in?
      @quote = current_user.quotes.build 
      @quotes = current_user.feed_quotes.order(id: :desc).page(params[:page])
      @user = User.find(current_user.id)
    end
  end
 
  private
   
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
