require 'rest-client'
require 'ox'
module Betradar
  class Request
    def get(url)
      data = RestClient.get(request_url(url), headers)
      Ox.load(data, mode: :hash)
    rescue StandardError => e
      Betradar::Error.on_complete(e)
    end

    def post(url, params = {})
      data = RestClient.post(request_url(url), params, headers)
      Ox.load(data, mode: :hash)
    rescue StandardError => e
      Betradar::Error.on_complete(e)
    end
  end
end
