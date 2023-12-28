class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :complete, :publish ]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      handle_success(@task, "created")
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      handle_success(@task, "updated")
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    handle_success(@task, "deleted")
  end

  def complete
    @task.update(completed: true)
    handle_success(@task, "completed")
  end

  def publish
    @task.update(published: true)
    handle_success(@task, "published")
  end

  def search
    @tasks = Task.search(search_params[:query])
    render :index
  end

  def create_generated
    @task = AiTaskGeneratorService.new(current_user, params[:goal]).generate_task
    @error_message = "Failed to generate task." unless @task
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def search_params
    params.permit(:query)
  end

  def send_task_notification(task, message)
    SlackNotificationService.send_task_notification(task, message)
  end

  def handle_success(task, action)
    send_task_notification(task, "Task '#{task.title}' #{action}!")
    redirect_to task, notice: "Task was successfully #{action}."
  end
end
