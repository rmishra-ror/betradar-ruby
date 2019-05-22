require 'spec_helper'

RSpec.describe 'Betradar::Api::BettingDescriptions' do
  before do
    @client = Betradar::Client.new('LAXMMGU88C7Cdhb4ja')
  end

  describe 'GET descriptions/en/markets.xml' do
    it 'should get the market_descriptions with mapping' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.market_descriptions
        expect(response[:market_descriptions]).to include(response_code: 'OK')

        expect(response[:market_descriptions])
          .to include(
            market: [
              { id: '282', name: 'Innings 1 to 5th top - {$competitor1} total', groups: 'all' },
              { outcomes: { outcome: [[{ id: '13', name: 'under {total}' }], [{ id: '12', name: 'over {total}' }]] } },
              { specifiers: { specifier: [{ name: 'total', type: 'decimal' }] } },
              { mappings: {
                mapping: [
                  { product_id: '1', product_ids: '1|4', sport_id: 'sr:sport:3',
                    market_id: '8:232', sov_template: '{total}' },
                  { mapping_outcome: [
                    { outcome_id: '13', product_outcome_id: '2528', product_outcome_name: 'under' }
                  ] },
                  { mapping_outcome: [
                    { outcome_id: '12', product_outcome_id: '2530', product_outcome_name: 'over' }
                  ] }
                ]
              } }
            ]
          )
      end
    end

    it 'should get the market_descriptions without mapping' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.market_descriptions(false)
        expect(response[:market_descriptions]).to include(response_code: 'OK')
        expect(response[:market_descriptions])
          .to include(market: [{ id: '282', name: 'Innings 1 to 5th top - {$competitor1} total', groups: 'all' },
                               { outcomes: { outcome: [[{ id: '13', name: 'under {total}' }],
                                                       [{ id: '12', name: 'over {total}' }]] } },
                               { specifiers: { specifier: [{ name: 'total', type: 'decimal' }] } }])
      end
    end
  end

  # # Match status
  # # Describes all match statuses.
  describe 'GET descriptions/en/match_status' do
    it 'should get the match_status descriptions' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.match_status
        expect(response[:match_status_descriptions]).to include(response_code: 'OK')

        expect(response[:match_status_descriptions]).to include(match_status: [
                                                                  { id: '0', description: 'Not started' },
                                                                  { sports: nil }
                                                                ])
      end
    end
  end

  # Void Reasons
  describe 'GET descriptions/void_reasons.xml' do
    it 'should get the void_reasons' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.void_reasons
        expect(response[:void_reasons_descriptions]).to include(response_code: 'OK')
        expect(response[:void_reasons_descriptions]).to include(void_reason: [{ id: '0', description: 'OTHER' }])
      end
    end
  end

  # Betstop descriptions
  describe 'GET descriptions/betstop_reasons.xml' do
    it 'should get the betstop_reasons' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.betstop_descriptions
        expect(response[:betstop_reasons_descriptions]).to include(response_code: 'OK')
        expect(response[:betstop_reasons_descriptions])
          .to include(betstop_reason: [{ id: '0', description: 'UNKNOWN' }])
      end
    end
  end

  # Betting Status
  describe 'GET descriptions/betting_status.xml' do
    it 'should get the betting status' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.betting_status
        expect(response[:betting_status_descriptions]).to include(response_code: 'OK')
        expect(response[:betting_status_descriptions]).to include(betting_status: [{ id: '1', description: 'GOAL' }])
      end
    end
  end

  # Outcome reasons
  describe 'GET descriptions/outcome_reasons.xml' do
    it 'should get the outcome_reasons' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.outcome_reasons
        expect(response[:outcome_reasons_descriptions]).to include(response_code: 'OK')
      end
    end
  end

  # Available producers
  describe 'GET descriptions/producers.xml' do
    it 'should get the Available producers' do
      VCR.use_cassette('betting_descriptions') do
        response = @client.producers
        expect(response[:producers]).to include(response_code: 'OK')
        expect(response[:producers]).to include(producer: [{ id: '1',
                                                             name: 'LO',
                                                             description: 'Live Odds',
                                                             api_url: 'https://api.betradar.com/v1/liveodds/',
                                                             active: 'true',
                                                             scope: 'live',
                                                             stateful_recovery_window_in_minutes: '4320' }])
      end
    end
  end
end
