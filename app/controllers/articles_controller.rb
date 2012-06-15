class ArticlesController < ApplicationController
  
  before_filter :require_login, :only => [:new, :create, :edit, :update, :delete]
  before_filter :find_article, :only => [:edit, :update, :delete, :show]

  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    if @article.save
      redirect_to :action => :index, :notice => "article was created"
    else
      render :action => :new
    end
  end
 
  def edit    
  end

  def update

    if @article.user_id == current_user.id || current_user.is_admin? 
    if @article.update_attributes(params[:article])
      redirect_to :action => :index, :notice =>"article was update"
    else
      render :action => :edit
    end
    else
      redirect_to root_url, :notice => "you can't update this article" 
    end
  end
  
  def show
   @comments = Comment.all
   @comment = Comment.new
  end

  def delete

    if @article.user_id == current_user.id
    Article.find_by_id(params[:id]).destroy
    redirect_to :action => :index
    else
      redirect_to root_url, :notice => "you can't delete this article" 
    end
  end
  
  private
  def find_article
    @article = Article.find_by_id(params[:id])
    if @article == nil
      flash[:error] = "the article not found"
      redirect_to articles_path 
    else 
      true
    end
  end	
end
