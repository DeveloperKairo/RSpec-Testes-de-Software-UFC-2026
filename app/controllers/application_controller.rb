class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  private
  def authenticate_request!
    unless current_user
      respond_to do |format|
        format.json { render json: { error: "Autenticação necessária" }, status: :unauthorized }
        format.html { redirect_to login_path, alert: "Por favor, faça login para acessar." }
      end
    end
  end

  def current_user
    if request.format.json?
      token = request.headers['Authorization']&.split(' ')&.last
      @current_user ||= User.where(auth_token: token).first if token
    else
      @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
    end
  end

  helper_method :current_user

  def not_found
    respond_to do |format|
      format.json { render json: { error: "Recurso não encontrado" }, status: :not_found }
      format.html { redirect_to root_path, alert: "Recurso não encontrado." }
    end
  end
end
