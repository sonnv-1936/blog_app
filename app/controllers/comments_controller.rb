class CommentsController < ApplicationController
  attr_reader :comment

  def create
    @comment = Comment.new comment_params
    comment.save
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id, :entry_id
  end
end
