class QuotesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def create
    book = Book.find_or_create_by(title: book_params[:title], author: book_params[:author]) do |book|
           book.title = book_params[:title]
           book.author = book_params[:author]
         end
           
    quote = current_user.quotes.new(quote_params)
    quote.book_id = book.id

        #quote.valid?
    if quote.save
      
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
  
  def update
    book = Book.find_or_create_by(title: book_params[:title], author: book_params[:author]) do |book|
            book.title = book_params[:title]
            book.author = book_params[:author]
            end
    
    if @quote.update(sentence: quote_params[:sentence], book_id: book.id)  
      flash[:success] = '正常に更新されました'
      redirect_to root_url
    else
      flash[:danger] = '更新されませんでした'
      redirect_back(fallback_location: root_path)
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
