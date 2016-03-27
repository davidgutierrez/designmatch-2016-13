
class DesignsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  include SqsHelper
  protect_from_forgery

  def create
    @proyect = Proyect.find(params["design"]["proyect"])
    @design = @proyect.designs.build(design_params)
    if @design.save
      flash[:success] = "Design created!"
      send_msg_to_queue(@design.id.to_s)
      redirect_to @proyect
    else
      render "new"
    end
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