class QuotesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit]
  
  def create
    book = Book.find_or_create_by(title: book_params[:title]) do |book|
           book.author = book_params[:author]
           
    @quote = current_user.quotes.new(quote_params)
    @quote.book_id = book.id
    end

        
    if @quote.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @user = User.find(current_user.id)
      @quotes = current_user.feed_quotes.order(id: :desc).page(params[:page])
      flash[:danger] = 'メッセージの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
 
  def destroy
    @quote.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    if logged_in?
      @quotes = current_user.feed_quotes.order(id: :desc).page(params[:page])
      @user = User.find(current_user.id)
      @quote = Quote.find(params[:id])
    end
  end
  
  private

  def quote_params
    params.require(:quote).permit(:sentence)
  end
  
  def book_params
    params.require(:quote).permit(:title, :author)
  end
  
  def correct_user
    @quote = current_user.quotes.find_by(id: params[:id])
    unless @quote
      redirect_to root_url
    end
  end
  
end
