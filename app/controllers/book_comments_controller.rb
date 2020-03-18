class BookCommentsController < ApplicationController
before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = BookComment.find(params[:book_id])
    # URLへの直リンクを禁止
    if comment.user != current_user
      # 1つ前のURLへ返す。
      redirect_to request.referer
    end
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
