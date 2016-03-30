
class DesignsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  include SqsHelper
  protect_from_forgery

  def create
    url = params["design"]["proyect_id"]
    print "\nsavinewewg\n"
    @design = Design.new(design_params)
  #  @design.proyect_id = url
    print "\nsaving\n"
    print @design.valid?
    print "\npararmdfdfs\n"
    if @design.save
    print @design
    print "\npararfdfddfms\n"
      flash[:success] = "Design created!"
      send_msg_to_queue(@design.id.to_s)
      redirect_to "/"+url
    else
      print "error"
      redirect_to "/"+url
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
      params.require(:design).permit(:email, :firstName, :lastName, :offer, :pictureOriginal, :proyect_id)
    end
end