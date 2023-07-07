class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @tasks = @tasks.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    @tasks = @tasks.where(status: params[:status]) if params[:status].present?
    @tasks = @tasks.order(expired_at: :desc) if params[:sort_expired]
  end
  

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created."
      redirect_to @task
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated."
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :expired_at, :status)
  end
end
