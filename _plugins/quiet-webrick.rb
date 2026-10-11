# `jekyll serve` (WEBrick) logs a scary ERROR + backtrace whenever the browser
# drops a connection early, e.g. on reload or LiveReload. It's harmless, so
# skip logging just those client-disconnect errors; real errors still show.
begin
  require "webrick"
rescue LoadError
  # webrick isn't available (not serving) — nothing to patch.
end

if defined?(WEBrick::BasicLog)
  module QuietWebrickDisconnects
    def error(msg)
      return if client_disconnect?(msg)

      super
    end

    private

    def client_disconnect?(msg)
      case msg
      when Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE, Errno::ENOTCONN
        true
      when Errno::EINVAL
        msg.message.include?("getpeername") # socket closed before it was accepted
      else
        false
      end
    end
  end

  WEBrick::BasicLog.prepend(QuietWebrickDisconnects)
end
