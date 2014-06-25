module ApplicationHelper

  def format_link(link)
    if link.start_with? 'http://'
      link
    else
      "http://#{link}"
    end
  end

  def format_datetime(d)
    d.strftime("%B %d, %Y at %I:%M%p")
  end


end
