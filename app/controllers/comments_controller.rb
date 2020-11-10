class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
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
      params.require(:comment).permit(:content, :commentable_type, :commentable_id)
    end
end
