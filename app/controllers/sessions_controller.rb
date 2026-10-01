class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    respond_to do |format|
      if user&.authenticate(params[:password])
        format.json do
          render json: {
            user: user.as_json(except: [:password_digest, :auth_token]),
            token: user.auth_token
          }
        end
        format.html do
          session[:user_id] = user.id
          redirect_to dashboard_path, notice: "Login realizado com sucesso."
        end
      else
        format.json { render json: { error: "Email ou senha inválidos" }, status: :unauthorized }
        format.html do
          flash.now[:alert] = "Email ou senha inválidos."
          render :new, status: :unauthorized
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to root_path, notice: "Logout realizado com sucesso." }
    end
  end
end
