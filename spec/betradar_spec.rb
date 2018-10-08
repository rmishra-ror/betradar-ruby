RSpec.describe Betradar do
  it 'has a version number' do
    expect(Betradar::VERSION).not_to be nil
  end

  describe Betradar::Client do
    let(:client) { Betradar::Client.new('asasa3fxvwervcv') }

    it 'should exist' do
      expect(client).to be_kind_of(Betradar::Client)
    end
  end
end
