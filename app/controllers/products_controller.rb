class ProductsController < ApplicationController
  before_filter :require_login, :only => [:new, :create, :edit, :update, :delete]
  before_filter :find_product, :only => [:edit, :update, :delete, :show]

  def new
    @product = Product.new
    @parent_category = Category.where(["parent_id IS not NULL"]).map{|x| [x.name, x.id]}
  end

  def index
    @product = Product.all
  end

  def edit
    @parent_category = Category.where(["parent_id IS not NULL"]).map{|x| [x.name, x.id]}
  end

  def delete
    if @product.user_id == current_user.id
    Product.find_by_id(params[:id]).destroy
    redirect_to :action => :index, :notice => "category was deleted"
    else
    redirect_to products_path, :notice => "you can't deleted this product"
    end
  end

  def update
    if @product.user_id == current_user.id
      if @product.update_attributes(params[:product])
        redirect_to products_path, :notice =>"product was update"
      else
        render :action => :edit
      end
    else
      redirect_to products_path, :notice => "you can't update this product"
    end
  end
 
  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    if @product.save
      redirect_to products_path, :notice => "product was created"
    else
      render :action => :new
    end
  end

  def show

  end

  private
  def find_product
    @product = Product.find_by_id(params[:id])
    if @product == nil
      flash[:error] = "the product not found"
      redirect_to products_path 
    else 
      true
    end
  end	
end
