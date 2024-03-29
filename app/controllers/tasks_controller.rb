class TasksController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def edit
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def create
    @task = current_user.tasks.build(params[:task])
      respond_to do |format|
        if @task.save
          format.html { redirect_to root_path, :flash => { :success => 'Task was successfully created.' } }
          format.js { reload_items }
        else
          format.html { redirect_to root_path, :flash => { :error => 'Describe the task.' } }
          format.js 
        end
      end
  end

  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.js { reload_items }
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  def destroy
    if @task.finished?
      @task.unfinish
    else
      @task.finish
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { reload_items }
    end
  end

  private

    def correct_user
      @task = Task.find(params[:id])
      redirect_to(root_path) unless current_user?(@task.user)
    end
  
end
