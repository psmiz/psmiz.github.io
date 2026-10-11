# jekyll-imagemagick logs a line for every responsive image on each build
# ("Searching files in …", "Adding static file …", "Generated N file(s)").
# Hide its info-level chatter; its warnings and errors still go through.
module QuietImagemagickLogs
  def info(topic, message = nil, &block)
    return if topic.to_s.start_with?("Imagemagick")

    super
  end
end

Jekyll::LogAdapter.prepend(QuietImagemagickLogs)
