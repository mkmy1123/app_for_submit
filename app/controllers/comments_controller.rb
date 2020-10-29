class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      redirect_back fallback_location: root_path
    end
  end

  private
    def comments_params
      params.require(:comment).permit(:name, :content, :commentable_type, :commentable_id)
    end
end
