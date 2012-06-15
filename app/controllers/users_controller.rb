class UsersController < ApplicationController
 before_filter :require_login, :only => [:edit, :update, :delete, :show, :index] 
 def new
     @user = User.new
  end

  def create
     if verify_recaptcha
       @user = User.new(params[:user])  
    if @user.save 
      redirect_to root_url, :notice => "Signed up!" 
      UserMailer.registration_confirmation(@user).deliver
    else
      render "new" 
    end
  else
    flash[:error] = "There was an error with the recaptcha code below.
                     Please re-enter the code and click submit."
    render "new"
  end
  end 

  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      redirect_to :action => :show, :notice =>"article was update"
    else
      render :action => :edit
    end

  end
  def index
    redirect_to :action => :show
  end
 

end
