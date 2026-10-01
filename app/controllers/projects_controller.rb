class ProjectsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects

    respond_to do |format|
      format.json { render json: @projects }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @project }
      format.html
    end
  end

  def new
    @project = current_user.projects.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.json { render json: @project, status: :created }
        format.html { redirect_to @project, notice: "Projeto criado com sucesso." }
      else
        format.json { render json: { errors: @project.errors }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.json { render json: @project }
        format.html { redirect_to @project, notice: "Projeto atualizado com sucesso." }
      else
        format.json { render json: { errors: @project.errors }, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to projects_path, notice: "Projeto excluído com sucesso." }
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
