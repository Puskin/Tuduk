class Task < ActiveRecord::Base

  attr_accessible :content, :category_id
  belongs_to :user
  belongs_to :category

  validates :content, presence: true
	validates :user_id, presence: true

  default_scope order: 'tasks.created_at DESC'

end
