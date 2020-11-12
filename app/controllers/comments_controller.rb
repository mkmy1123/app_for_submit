class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
    if params[:book_id]
      @comment.commentable = Book.find_by(params[:book_id])
    elsif params[:report_id]
      @comment.commentable = Report.find_by(params[:report_id])
    end
    if @comment.save
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    redirect_back fallback_location: root_path
  end

  private
    def comments_params
      params.require(:comment).permit(:content)
    end
end
