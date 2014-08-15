class ArticlesController < ApplicationController
	before_action :signed_in?, only: [:create, :destroy]
	def new
		redirect_to root_url, alert:"Please login" unless signed_in?

		@article = Article.new
	end

	def index
		@articles = Article.all.order("id DESC").page(params[:page]).per(10)
		@article = Article.new
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "Blog post created!"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def edit
		@article = Article.find(params[:id])
		redirect_to @article, alert:"You do not have permission to edit this post." unless current_user == @article.user
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comments = @article.comments.page(params[:page]).per(10)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:success] = "Blog post was deleted."
		redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title,:body)
		end
end
