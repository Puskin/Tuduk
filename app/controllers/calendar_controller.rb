class CalendarController < ApplicationController
  
  def index
  	@month = (params[:month] || Time.zone.now.month).to_i
    @year = (params[:year] || Time.zone.now.year).to_i

    user = User.find(current_user)

    @first_day_of_week = 1
    @shown_month = Date.civil(@year, @month)
    @event_strips = user.tasks.event_strips_for_month(@shown_month, @first_day_of_week)
  end

end
