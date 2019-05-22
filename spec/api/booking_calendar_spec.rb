require 'spec_helper'

RSpec.describe 'Betradar::Api::BettingDescriptions' do
  before do
    @client = Betradar::Client.new('LAXMMGU88C7Cdhb4ja')
  end

  describe 'POST "liveodds/booking-calendar/events/match_id/book"' do
    it 'should raise error if match_id is wrong' do
      VCR.use_cassette('booking-calendar') do
        expect { @client.liveodds_coverage(11_223_344) }.to raise_error(/The match is unknown/)
      end
    end

    it 'should raise error if match is non bookable' do
      VCR.use_cassette('booking-calendar') do
        expect { @client.liveodds_coverage('sr:match:15927538') }
          .to raise_error(/The match is not offered within our live betting services/)
      end
    end

    it 'should raise erro if match is already booked' do
      VCR.use_cassette('booking-calendar') do
        expect { @client.liveodds_coverage('sr:match:15011517') }.to raise_error(/The match is booked/)
      end
    end

    it 'should book a match if match is bookable' do
      VCR.use_cassette('booking-calendar') do
        data = @client.liveodds_coverage('sr:match:15011509')
        expect(data[:response]).to include(response_code: 'OK')
        expect(data[:response])
          .to include(action: 'Request for booking an event : sr:match:15011509 from bookmaker: 21951 received')
      end
    end
  end
end
