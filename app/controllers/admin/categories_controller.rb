class Admin::CategoriesController < Admin::ApplicationController 
  before_filter :require_admin_login
  before_filter :find_category, :only => [:edit, :update, :delete, :show] 

  def index
    @category = Category.all
  end

  def new
    @category = Category.new
    @parent_category = Category.where(["parent_id IS NULL"]).map{|x| [x.name, x.id]}
  end

  def edit 
   
     @parent_category = Category.where(["parent_id IS NULL"]).map{|x| [x.name, x.id]}
  end

  def delete
     @category = Category.find_by_id(params[:id])
    if @category.parent_id == nil
      Category.find_by_id(params[:id]).destroy
      if Category.find_by_parent_id(@category.id) == nil
      redirect_to admin_categories_path, :notice => "category was deleted"
      else
      Category.find_by_parent_id(@category.id).destroy
      redirect_to admin_categories_path, :notice => "category was deleted"
      end
    else
    Category.find_by_id(params[:id]).destroy
    redirect_to admin_categories_path, :notice => "category was deleted"
    end
  end

  def update
 
    if @category.update_attributes(params[:category])
      redirect_to :action => :index, :notice =>"article was update"
    else
      render :action => :edit
    end
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path, :notice => "category was created"
    else
      render :action => :new
    end
  end

  def show
   
  end
  
  private
  def find_category
    @category = Category.find_by_id(params[:id])
    if @category == nil
      flash[:error] = "the product not found"
      redirect_to admin_category_path 
    else 
      true
    end
  end
  
end
