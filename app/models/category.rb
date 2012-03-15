class Category < ActiveRecord::Base

	attr_accessible :title

	belongs_to :user
	has_many :tasks

	validates :title, presence: true
	validates :user_id, presence: true

end
