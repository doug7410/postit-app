module ApplicationHelper

  def format_link(link)
    link.start_with?('http://') ? link : "http://#{link}"
  end

  def format_datetime(dt)
    
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("%B %d, %Y at %I:%M%p %Z") if dt
  
  end


end
