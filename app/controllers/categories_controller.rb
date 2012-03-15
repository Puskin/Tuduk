class CategoriesController < ApplicationController

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = current_user.categories.build(params[:category])
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, :flash => { :success => 'Category was successfully created.' } }
        format.js { @categories = Category.find_all_by_user_id(current_user.id) }
      else
        format.html { redirect_to root_path, :flash => { :error => "Title can't be blank!"} }
        format.js { @categories = Category.find_all_by_user_id(current_user.id) }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
