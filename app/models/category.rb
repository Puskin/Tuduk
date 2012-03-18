class Category < ActiveRecord::Base

	attr_accessible :title

	belongs_to :user
	has_many :tasks

	validates :title, presence: true
	validates :user_id, presence: true

	def self.detach_tasks(category_id)
		tasks = Task.find_all_by_category_id(category_id)
		tasks.each do |task|
			task.update_attributes!(:category_id => nil)
		end
	end


end
