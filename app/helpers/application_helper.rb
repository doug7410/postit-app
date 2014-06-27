module ApplicationHelper

  def format_link(link)
    link.start_with?('http://') ? link : "http://#{link}"
  end

  def format_datetime(dt)
    if dt
    dt.strftime("%B %d, %Y at %I:%M%p %Z")
    end
  end


end
