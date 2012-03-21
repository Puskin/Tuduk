class CategoriesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def edit
    respond_to do |format|
      format.html
      format.js { reload_items }
    end
  end

  def create
    @category = current_user.categories.build(params[:category])
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, :flash => { :success => 'Category was successfully created.' } }
        format.js { reload_items }
      else
        format.html { redirect_to root_path, :flash => { :error => "Title can't be blank!"} }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.js { reload_items }
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  def destroy
    Category.detach_tasks(@category.id)
    @category.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { reload_items }
    end
  end

  private

    def correct_user
      @category = Category.find(params[:id])
      redirect_to(root_path) unless current_user?(@category.user)
    end 

end
