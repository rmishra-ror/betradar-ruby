module Betradar
  class Client < Request
    attr_accessor :api_key
    BASE_URL= 'https://api.betradar.com/v1'
    include ::Api::OddsRecover
    include ::Api::StaticSportEventInformation
    include ::Api::SportEventInformation
    include ::Api::BettingDescriptions
    include ::Api::Probability
    include ::Api::EntityDescriptions
    include ::Api::BookingCalendar

    def initialize(api_key)
      @api_key = api_key
    end

    private

    def request_url(path)
      "#{BASE_URL}/#{path}"
    end

    def headers
      { "x-access-token": api_key }
    end
  end
end
