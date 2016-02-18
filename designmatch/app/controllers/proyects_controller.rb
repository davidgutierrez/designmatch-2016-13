class ProyectsController < ApplicationController
   before_action :logged_in_user, only: [:create, :destroy]
   before_action :correct_user,   only: :destroy
   
  def create
    @proyect = current_user.proyects.build(proyect_params)
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
    @proyect = Proyect.find(params[:id])
  end

  def edit
    @proyect = Proyect.find(params[:id])
  end

  def update
    @proyect = Proyect.find(params[:id])
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
      @proyect = current_user.proyects.find_by(id: params[:id])
      redirect_to root_url if @proyect.nil?
    end
end
