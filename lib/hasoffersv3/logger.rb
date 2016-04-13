class HasOffersV3
  class Logger
    LABEL = '[HasOffersV3]'.freeze

    attr_reader :log

    def initialize(log = nil)
      @log = log
    end

    def log_request(request, uri)
      log_http(request, "Request: #{request.method} #{uri}")
    end

    def log_response(response)
      log_http(response, "Response: HTTP/#{response.http_version} #{response.code} #{response.message}")
    end

    private

    def log_http(http, first_line)
      return unless log

      message = format_message(http, first_line)
      log.info(message)
    end

    def format_message(http, first_line)
      StringIO.open do |s|
        s.puts("#{LABEL} #{first_line}")
        append_headers(s, http.each_capitalized)
        s.puts(http.body) unless http.body.to_s.empty?
        s.string
      end
    end

    def append_headers(message, headers)
      headers.each do |name, value|
        message.puts("#{name}: #{value}")
      end

      message.puts
    end
  end
end
