class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @proyect = Proyect.new
      @feed_items = Proyect.where(:user_id =>  session[:user_id]).all #.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end

  def contact
  end
  
end
