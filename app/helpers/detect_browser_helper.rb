module DetectBrowserHelper
  def client_browser_name
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    if user_agent =~ /msie/i
      "Internet Explorer"
    elsif user_agent =~ /konqueror/i
      "Konqueror"
    elsif user_agent =~ /firefox/i
      "Mozilla"
    elsif user_agent =~ /opera/i
      "Opera"
    elsif user_agent =~ /applewebkit/i
      "Safari"
    else
      "Unknown"
    end
  end
end
