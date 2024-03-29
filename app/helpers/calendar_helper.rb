module CalendarHelper

	def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end

  # custom options for this calendar
  def event_calendar_options
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>",
      :width => 900, :height => 500,
      :first_day_of_week => @first_day_of_week
    }
  end

  def event_calendar
    calendar event_calendar_options do |args|
      event = args[:event]
      cssClass = " finished" if event.finished?
      title = event.content if event.content.length > 22
      link_to truncate(event.content, :length => 22), "#", :class => "calendar_tooltip#{cssClass}", :rel => "tooltip", :title => title  
    end
  end

end
