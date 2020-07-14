class BooksController < ApplicationController
  
  def title
    if logged_in?
    @quote = current_user.quotes.build 
    @user = User.find(current_user.id)
    @title = params[:title]
    @books = Book.where(title: params[:title])
    @books_quotes = Quote.where(book_id: @books.ids)
    @quotes = @books_quotes.order(id: :desc).page(params[:page])
    
    else
    
    
    @title = params[:title]
    @books = Book.where(title: params[:title])
    @books_quotes = Quote.where(book_id: @books.ids)
    @quotes = @books_quotes.order(id: :desc).page(params[:page])
    
    end
  end
  
  def author
    if logged_in?
    @quote = current_user.quotes.build 
    @user = User.find(current_user.id)
    @author = params[:author]
    @books = Book.where(author: params[:author])
    @books_quotes = Quote.where(book_id: @books.ids)
    @quotes = @books_quotes.order(id: :desc).page(params[:page])
    
    else
    @author = params[:author]
    @books = Book.where(author: params[:author])
    @books_quotes = Quote.where(book_id: @books.ids)
    @quotes = @books_quotes.order(id: :desc).page(params[:page])
      
    end
  end



private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def book_params
    params.require(:book).permit(:title, :author)
  end

end 