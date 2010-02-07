class MachinesController < ApplicationController

def index
    @loc = "machines"
    @machines = Machine.find(:all)

    if !@machines then
        flash[:notice] = 'No machines found!'

        if params[:format]==nil then 
          render :html => @machines
          return 
        end
    
        respond_to do |format|
          format.html  { render :html => flash }
          format.xml   { render :xml => flash.to_xml }
          format.json  { render :json => flash.to_json(:callback => params[:callback], :except => [:command]) }
        end
    else 

    if params[:format]==nil then 
      render :html => @machines
      return 
    end
    
    respond_to do |format|
      format.html  { render :html => @machines }
      format.xml   { render :xml => @machines.to_xml }
      format.json  { render :json => @machines.to_json(:callback => params[:callback], :except => [:command]) }
    end

    end

end




def show
    @loc = "machines"
    
    @machine = Machine.find_by_model_name(params[:name])

    if !@machine then
        flash[:notice] = 'Not found!'

        if params[:format]==nil then 
          render :html => @machine
          return 
        end
    
        respond_to do |format|
          format.html  { render :html => flash }
          format.xml   { render :xml => flash.to_xml }
          format.json  { render :json => flash.to_json(:callback => params[:callback], :except => [:command]) }
        end
    else 

    if params[:format]==nil then 
      render :html => @machine
      return 
    end
    
    respond_to do |format|
      format.html  { render :html => @machine }
      format.xml   { render :xml => @machine.to_xml(:include => [:am_technology, :company, :models]) }
      format.json  { render :json => @machine.to_json(:callback => params[:callback], :except => [:command]) }
    end

    end

end









end
