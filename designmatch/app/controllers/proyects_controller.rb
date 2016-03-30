class ProyectsController < ApplicationController
   before_action :logged_in_user, only: [:create, :destroy]
   before_action :correct_user,   only: :destroy
   
  def create
    @proyect =  Proyect.new(proyect_params)
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
    url = params[:webPage]+"/"+params[:url]
    @proyect = Proyect.find_by_url(url)
    @design  = Design.new
    @designs = Design.all #@proyect.designs.paginate(page: params[:page], :per_page => 10)
  end

  def edit
    url = params[:webPage]+"/"+params[:url]
    @proyect = Proyect.find_by_url(url)
  end

  def update
    url = params[:proyect][:url]
    @proyect = Proyect.find_by_url(url)
    if @proyect.update_attributes(proyect_params)
      flash[:success] = "Proyect updated"
      redirect_to "/"+url
    else
      render 'edit'
    end
  end
  
  private

    def proyect_params
      params.require(:proyect).permit(:name, :description, :value)
    end
    
    def correct_user
      @proyect = Proyect.find_by_url(self.url)
      redirect_to root_url if @proyect.nil?
    end
end
