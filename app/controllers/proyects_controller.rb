class ProyectsController < ApplicationController
  include DesignsHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_proyect, only: [:edit, :update, :destroy]
  
  def create
    @proyect =  Proyect.new(proyect_params)
    @proyect.user = current_user
    @proyect.user_id = session[:user_id]
    if @proyect.save
      flash[:success] = "Proyect created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  
  def destroy
    @proyect.destroy 
    flash[:success] = "Proyect deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @design  = Design.new
    @proyect = Proyect.find(params[:url])
    all_converted_designs_in_competition(params[:url])
  end

#  def edit
#    @proyect = Proyect.find(params[:id])
#  end

  def update
#    @proyect = Proyect.find(params[:id])
    if @proyect.update_attributes(proyect_params)
      flash[:success] = "Proyect updated"
      redirect_to @proyect
    else
      render 'edit'
    end
  end
  
  private

    def proyect_params
      params.require(:proyect).permit(:name, :description, :value)
    end
    
    def correct_user
      @proyect = current_user.proyects.find(params[:id])
      redirect_to root_url if @proyect.nil?
    end
    
    def set_proyect
		  print "/////////////////////"
		  id = params[:id]
		  if id.nil?
		    id = params[:url]
		  end
		  print "/////////////////////\n"
		  @proyect = Proyect.find(id)
    end
end
