require 'foundations/compact'
require 'httpclient'

module Test
  include Waves::Foundations::Compact


  module Configurations
	class Development
	 application.use Rack::Static, :urls => ["/client"], :root => "public"
 	end
  end

  module Resources
	class Map
		on(true) { forward }
	end
  end
end

def forward
  b = request.body.string
  headers = {}
  rack_headers = request.rack_request.env.keys
  rack_headers.each do |h|
    if h =~ /^HTTP/
      headers.merge!({h[5, h.length] => request.rack_request.env[h]} )
    end
  end
  client = HTTPClient.new
  return client.get_content( request.params['request_uri'], request.params, headers ) if request.method == :get
  return client.post_content( request.params['request_uri'], request.params, headers ) if request.method == :post
end
