class CommentsController < ApplicationController
  attr_reader :comment

  before_action :find_comment, :authenticate_administrator, only: :destroy

  def create
    @comment = Comment.new comment_params
    comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id, :entry_id
  end

  def find_comment
    @comment = Comment.find_by id: params[:comment_id]
  end
end
