class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @proyect = Proyect.new
      user = User.find(session[:user_id])
      @feed_items = user.feed #.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end

  def contact
  end
  
end
