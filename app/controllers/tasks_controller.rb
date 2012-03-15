class TasksController < ApplicationController

  before_filter :signed_in_user

  def index
    @tasks = Task.all
  end


  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(params[:task])
      respond_to do |format|
        if @task.save
          format.html { redirect_to root_path, :flash => { :success => 'Task was successfully created.' } }
          format.js { @tasks = current_user.tasks }
        else
          format.html { redirect_to root_path, :flash => { :error => 'Describe the task.' } }
          format.js 
        end
      end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { @tasks = current_user.tasks }
    end
  end
  
end
