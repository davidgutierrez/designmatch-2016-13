class DesignsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]

  def create
    design_params
    debugger
    
    @design = Design.new(design_params)
    if @design.save
      flash[:success] = "Design created!"
      redirect_to @proyect
    else
      render @proyect
    end
  end

  def destroy
  end
  
    private

    def design_params
      params.require(:design).permit(:email, :firstName, :lastName, :proyect)
    end
    
end