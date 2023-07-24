class TasksController < ApplicationController
  def index
    if params[:label_id].present?
      @tasks = Label.find(params[:label_id]).tasks
    else
      @tasks = Task.all
    end

    @tasks = @tasks.search_by_name(params[:name])
    @tasks = @tasks.search_by_status(params[:status])
    @tasks = @tasks.sort_by_expired(params[:sort_expired])
    @tasks = @tasks.sort_by_priority(params[:sort_priority]) if params[:sort_priority]
    @tasks = @tasks.where(user_id: current_user.id)
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end  

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created."
      redirect_to @task
    else
      render :new
    end
  end
  
  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated."
      redirect_to @task
    else
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def task_params
  params.require(:task).permit(:name, :description, :expired_at, :status, :priority, label_ids: [])
  end
  end
