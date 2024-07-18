require 'rails_helper'

RSpec.describe TflArrivals do
  subject(:tfl_arrivals) { described_class.arrivals(stop_point_id) }

  let(:stop_point_id) { '940GZZLUGPS' }

  before do
    stub_request(:get, /api.tfl.gov.uk/)
      .with(headers: { 'Accept' => '*/*' })
      .to_return(status: response_status, body: response_body)
  end

  describe '#arrivals' do
    context 'when there is a valid response' do
      let(:response_status) { 200 }
      let(:response_body) { file_fixture('great_portland_street_arrivals.json').read }

      it 'returns a non-empty collection of arrivals' do
        expect(tfl_arrivals).to be_present
      end

      it 'returns expected arrival data' do
        first_arrival = tfl_arrivals.first

        expect(first_arrival).to have_attributes(
          platform_name: 'Eastbound - Platform 2',
          station_name: 'Great Portland Street Underground Station',
          towards: 'Edgware Road (Circle)',
          time_to_station: 1035,
          line_name: 'Circle',
          line_id: 'circle'
        )
      end

      context 'when there is an empty collection' do
        let(:response_status) { 200 }
        let(:response_body) { [].to_json }

        it 'returns an empty list' do
          expect(tfl_arrivals).to be_empty
        end
      end
    end

    context 'when there is an resource not found response' do
      let(:response_status) { 404 }
      let(:response_body) { nil }

      it 'raises a StationNotFoundError' do
        expect { tfl_arrivals }.to raise_error(TflArrivals::StationNotFoundError)
      end
    end
  end
end
