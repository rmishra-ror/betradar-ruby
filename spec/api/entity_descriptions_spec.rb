require 'spec_helper'

RSpec.describe 'Betradar::Api::EntityDescriptions' do
  before do
    @client = Betradar::Client.new('LAXMMGU88C7Cdhb4ja')
  end

  describe 'GET "sports/en/players/:player_id/profile.xml"' do
    it 'should raise error if player_id is wrong' do
      VCR.use_cassette('entity_descriptions') do
        expect { @client.player_profile('sr:player:1s1223344') }.to raise_error(/Invalid identifier/)
      end
    end

    it 'should return player profile if player_id is correct' do
      VCR.use_cassette('entity_descriptions') do
        expect(@client.player_profile('sr:player:947')[:player_profile])
          .to include(player: [{ id: 'sr:player:947',
                                 name: 'Barnard, Lee',
                                 full_name: 'Lee Barnard',
                                 type: 'forward',
                                 date_of_birth: '1984-07-18',
                                 nationality: 'England',
                                 country_code: 'ENG',
                                 height: '178',
                                 weight: '68',
                                 gender: 'male' }])
      end
    end
  end

  describe 'GET "sports/en/competitors/:competitor_id/profile.xml"' do
    it 'should raise error if competitor_id is wrong' do
      VCR.use_cassette('entity_descriptions') do
        expect { @client.competitor_information('sr:competitor:1a1') }.to raise_error(/Invalid identifier/)
      end
    end

    it 'should return player profile if player_id is correct' do
      VCR.use_cassette('entity_descriptions') do
        expect(@client.competitor_information('sr:competitor:245739')[:competitor_profile])
          .to include(competitor: [
                        { id: 'sr:competitor:245739', name: 'WUNDER, MARKUS',
                          country: 'Germany', country_code: 'DEU', abbreviation: 'WUN' },
                        { sport: [{ id: 'sr:sport:5', name: 'Tennis' }] },
                        { category: [{ id: 'sr:category:785', name: 'ITF Men' }] }
                      ])
      end
    end
  end
end
