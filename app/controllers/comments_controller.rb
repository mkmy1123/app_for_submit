class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]

  def create
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
    @comment.commentable = @commentable
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

    def set_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.classify.constantize.find(id)
    end
end
