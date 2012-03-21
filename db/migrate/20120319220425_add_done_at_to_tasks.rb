class AddDoneAtToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :done_at, :datetime

  end
end
