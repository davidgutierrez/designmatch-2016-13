module SessionsHelper

  # Logs in the given usuario.
  def log_in(usuario)
    session[:usuario_id] = usuario.id
  end
  
  # Recuerda un usuario en una session persistente.
  def remember(usuario)
    usuario.remember
    cookies.permanent.signed[:usuario_id] = usuario.id
    cookies.permanent[:remember_token]    = usuario.remember_token
  end
  
    # Returns the current logged-in usuario (if any).
  def current_usuario
      if (usuario_id = session[:usuario_id])
      @current_uusuario ||= Usuario.find_by(id: usuario_id)
     elsif (usuario_id = cookies.signed[:usuario_id])
      usuario = Usuario.find_by(id: usuario_id)
      if usuario && usuario.authenticated?(cookies[:remember_token])
        log_in usuario
        @current_usuario = usuario
      end
    end
  end

    
  # Returns true if the usuario is logged in, false otherwise.
  def logged_in?
    !current_usuario.nil?
  end
  
 # Forgets a persistent session.
  def forget(usuario)
    usuario.forget
    cookies.delete(:usuario_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current usuario.
  def log_out
    forget(current_usuario)
    session.delete(:usuario_id)
    @current_usuario = nil
  end
  
end
