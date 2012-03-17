class CategoriesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy]


  def edit
  end

  def create
    @category = current_user.categories.build(params[:category])
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, :flash => { :success => 'Category was successfully created.' } }
        format.js {
          @task = current_user.tasks.build 
          @categories = Category.find_all_by_user_id(current_user.id) 
        }
      else
        format.html { redirect_to root_path, :flash => { :error => "Title can't be blank!"} }
        format.js { @categories = Category.find_all_by_user_id(current_user.id) }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  private

    def correct_user
      @category = Category.find(params[:id])
      redirect_to(root_path) unless current_user?(@category.user)
    end 

end
