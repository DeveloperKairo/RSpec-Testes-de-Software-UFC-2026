class TasksController < ApplicationController
  before_action :authenticate_request!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @project.tasks
    respond_to do |format|
      format.json { render json: @tasks }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @task }
      format.html
    end
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.json { render json: @task, status: :created }
        format.html { redirect_to @project, notice: "Tarefa criada com sucesso." }
      else
        format.json { render json: { errors: @task.errors }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.json { render json: @task }
        format.html { redirect_to @project, notice: "Tarefa atualizada com sucesso." }
      else
        format.json { render json: { errors: @task.errors }, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to @project, notice: "Tarefa excluída com sucesso." }
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
