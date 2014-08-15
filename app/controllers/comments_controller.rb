class CommentsController < ApplicationController

	def new
	  @comment = Comment.new
	end

	def create
	  @article = Article.find(params[:article_id])
	  @comment = @article.comments.build(comment_params)
	  @comment.user = current_user
	  
	  flash[:success] = "Comment posted successfully!" if @comment.save
	  redirect_to @comment.article
	end

	def destroy
      @comment = Comment.find(params[:id])
      @article = Article.find(@comment.article_id)
      @comment.destroy
      redirect_to @article
	end

	private
	  def comment_params
	  	params.require(:comment).permit(:comment, :article_id)
	  end
end
