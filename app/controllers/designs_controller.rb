
class DesignsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  include SqsHelper
  protect_from_forgery :except => :create 

  def create
    @proyect  = Proyect.find(params["design"]["proyect"])
    @design   = Design.new(design_params)
    @design.proyect_id = @proyect.id
    @design.consecutivo ||= Design.all.count
     picture = params["design"]["pictureOriginal"]
    @design.original_filename = picture.original_filename 
    if @design.save
      flash[:success] = "Design created!"
      send_msg_to_queue(@design.id.to_s)
      redirect_to @proyect
    else
        print "error\n"
      for error in @design.errors
        print error
        print "\n"
      end
        print "\nerror\n"
      render "new"
    end
  end
  
  def new
    @design = Design.new
#    @proyect = Proyect.find(params["design"]["proyect"])
#    @design.proyect_id = @proyect.id
  end

  def destroy
  end
  
    private

    def design_params
      params.require(:design).permit(:email, :firstName, :lastName, :offer, :pictureOriginal, :proyect_id)
    end
end