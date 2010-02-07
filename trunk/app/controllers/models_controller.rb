class ModelsController < ApplicationController


  def index
    @loc = "models"
  end

  def create
    @loc = "models"
  end

  def new
    @loc = "models"
  end

  def show
    @loc = "models"
    @model = Model.find_by_name(params[:name])

#    respond_to do |format|
#      format.xmlj  { render :xml => }
#    end

  end

end
