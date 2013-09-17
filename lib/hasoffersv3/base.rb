module HasOffersV3
  class Base
    class << self
      def get_request(target, method, params, &block)
        if block.nil?
          make_request(:get, target, method, params)
        else
          page = 1
          begin
            response = make_request(:get, target, method, params.merge(page: page))
            block.call response
            page += 1
          end until page > (response.page_info['page_count'] || 1)
        end
      end

      def post_request(target, method, params)
        make_request(:post, target, method, params)
      end

      def requires!(hash, required_params)
        missing_params = []
        required_params.each do |param|
          missing_params.push param unless hash.has_key?(param)
        end
        unless missing_params.empty?
          raise ArgumentError.new("Missing required parameter(s): #{missing_params.join(', ')}")
        end
      end

    private

      def new_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.read_timeout = 600
        http
      end

      def query_string(data_hash)
        # Rails to_params adds an extra open close brackets to multi-dimensional array parameters which
        # hasoffers doesn't like, so the gsub here takes care of that.
        data_hash.to_param.gsub(/\[\]\[/,'[')
      end

      def make_request(http_method, target, method, params)
        data = build_request_params(method, params)
        if http_method == :post
          uri               = URI.parse("#{HasOffersV3.configuration.base_uri}/#{target}.json")
          http              = new_http(uri)
          raw_request       = Net::HTTP::Post.new(uri.request_uri)
          raw_request.body  = query_string data
        else # assume get
          uri               = URI.parse("#{HasOffersV3.configuration.base_uri}/#{target}.json?#{query_string(data)}")
          http              = new_http(uri)
          raw_request       = Net::HTTP::Get.new(uri.request_uri)
        end
        http_response = http.request raw_request

        Response.new(http_response)
      end

      def build_request_params(method, params)
        params['Method'] = method
        params.merge NetworkId: HasOffersV3.configuration.network_id, NetworkToken: HasOffersV3.configuration.api_key
      end
    end
  end
end