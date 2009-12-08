class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    if (!params[:user]) then
      @user = User.new
      render :action => :new
    else 
      @user = User.new(params[:user])

      # Saving without session maintenance to skip
      # auto-login which can't happen here because
      # the User has not yet been activated
      if @user.save_without_session_maintenance
        @user.deliver_activation_instructions!
        flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
        redirect_to root_url
      else
        render :action => :new
      end
    end

  end
  
  def create
    @user = User.new
 
    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
