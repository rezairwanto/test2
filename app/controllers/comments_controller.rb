class CommentsController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :edit, :update, :delete]
  def create
  respond_to do |format|
   @comment = Comment.new(params[:comment])
   @comment.user_id = current_user.id
   if @comment.save
     format.html { redirect_to(article_path(@comment.article_id), :notice => 'Comment was successfully created.') }
     format.js
   end
 end
 end
end
