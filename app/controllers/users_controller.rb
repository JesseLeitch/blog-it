class UsersController < ApplicationController
  def index
  	@user = Users.all
  end

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @article = Article.new
    @articles = @user.articles.order("id DESC").page(params[:page]).per(10)
  end

  def create
  	@user = User.new(params.require(:user).permit(:email,:password,:password_confirmation,:image))
  	if @user.save
  		redirect_to root_url, :notice => "Signed up!"
  	else
  		render "new"
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:image))
      redirect_to @user, :notice => "Updated avatar!"
    else
      logger.debug @user.errors.inspect
    end
  end
end
