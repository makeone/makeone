class ModelsController < ApplicationController


  def index
  end

  def create
  end

  def new
  end

  def show
    @model = Model.find_by_name(params[:name])

#    respond_to do |format|
#      format.xmlj  { render :xml => }
#    end

  end

end
