class DesignsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  protect_from_forgery

  def create
    @proyect = Proyect.find(params["design"]["proyect"])
    @design = @proyect.designs.build(design_params)
    if @design.save
      flash[:success] = "Design created!"
      redirect_to @proyect
    else
      #@feed_items = []
      render "new"
      # respond_to do |format| 
      #   format.js {render inline: "location.reload();" } 
      # end
    end
    Thread.new { GC.start }
  end
  
  def new
    @proyect = Proyect.find(params["design"]["proyect"])
    @design = Design.new
    @design.proyect_id = @proyect.id
  end

  def destroy
  end
  
    private

    def design_params
      params.require(:design).permit(:email, :firstName, :lastName, :offer, :pictureOriginal)

    end
end