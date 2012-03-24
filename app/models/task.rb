class Task < ActiveRecord::Base

  attr_accessible :content, :category_id, :due_date
  belongs_to :user
  belongs_to :category

  has_event_calendar :start_at_field  => 'due_date', :end_at_field => 'due_date'

  validates :content, presence: true
	validates :user_id, presence: true

  default_scope order: 'tasks.created_at DESC'

  scope :unfinished, lambda { where("tasks.done_at IS NULL") }
  scope :finished, lambda { where("tasks.done_at IS NOT NULL AND tasks.done_at <= ?", Time.zone.now) }

  scope :today, lambda { unfinished.where("tasks.due_date IS NOT NULL AND tasks.due_date BETWEEN ? AND ?", Time.zone.now.at_beginning_of_day, Time.zone.now.end_of_day) }  
  scope :tomorrow, lambda { unfinished.where("tasks.due_date IS NOT NULL AND tasks.due_date BETWEEN ? AND ?", Time.zone.now.at_beginning_of_day+1.day, Time.zone.now.end_of_day+1.day) }  
  scope :week, lambda { unfinished.where("tasks.due_date IS NOT NULL AND tasks.due_date BETWEEN ? AND ?", Time.zone.now.at_beginning_of_day, Time.zone.now+7.days) }  

  scope :overdue, lambda { unfinished.where("tasks.due_date IS NOT NULL AND tasks.due_date <= ?", Time.zone.now) }  


  def self.search(search)
	  if search
	    find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
	  end
	end

  def finish 
    if self.finished?
      false
    else
      self.done_at = Time.now
      save!
    end
  end

  def unfinish 
    if self.finished?
      self.done_at = nil
      save!
    else
      false
    end
  end

  def finished?
    if self.done_at == nil
      false
    else
      true if self.done_at < Time.now
    end
  end

end
