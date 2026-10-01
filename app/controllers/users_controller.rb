class UsersController < ApplicationController
  before_action :authenticate_request!, only: [:me]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render json: { user: @user.as_json(except: [:password_digest, :auth_token]) }, status: :created }
        format.html do
          session[:user_id] = @user.id
          redirect_to dashboard_path, notice: "Conta criada com sucesso!"
        end
      else
        format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def me
    render json: { user: current_user.as_json(except: [:password_digest, :auth_token]) }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :age, :password, :password_confirmation)
  end
end
