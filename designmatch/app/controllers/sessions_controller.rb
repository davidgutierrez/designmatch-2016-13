class SessionsController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by(email: params[:session][:email].downcase)
    if usuario && usuario.authenticate(params[:session][:password])
      log_in usuario
      params[:session][:remember_me] == '1' ? remember(usuario) : forget(usuario)
      redirect_to usuario
    else
      flash.now[:danger] = 'Combinación invalida de email/password'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
