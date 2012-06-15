class HomeController < ApplicationController
  
  def index
     @product = Product.since(1.days.ago)
     @article = Article.since(1.days.ago)
  end

  def showarticle
    @article = Article.find(params[:id])
    @comments = Comment.all
    @comment = Comment.new
  end

  def showproduct
    @product = Product.find(params[:id])
  end
end
