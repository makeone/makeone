class HomeController < ApplicationController

  def index
    @loc = "home"
    @feature = params[:id]
  end

#  def forgot_password
#  end

#  def new_account
#  end


end
