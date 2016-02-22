class DesignsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]

  def create
    @proyect = Proyect.find(params["design"]["proyect"])
    @design = @proyect.designs.build(design_params)
    if @design.save
      @design.updateInProcess
      flash[:success] = "Design created!"
      redirect_to @proyect
    else
      @feed_items = []
      redirect_to @proyect
    end
  end

  def destroy
  end
  
    private

    def design_params
      params.require(:design).permit(:email, :firstName, :lastName, :offer, :pictureOriginal)

    end
end