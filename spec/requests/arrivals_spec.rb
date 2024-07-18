require 'rails_helper'

RSpec.describe "Arrivals" do
  let(:great_portland_street_stop_point_id) { '940GZZLUGPS' }

  describe 'GET /' do
    it 'redirects to Great Portland Street arrivals page' do
      get '/'

      expect(response).to redirect_to(arrivals_path(great_portland_street_stop_point_id))
    end
  end

  describe 'GET /arrivals/invalid-stop-point-id' do
    before do
      stub_request(:get, /api.tfl.gov.uk/)
        .with(headers: { 'Accept' => '*/*' })
        .to_return(status: 404, body: nil)
    end

    it 'returns a descriptive 404 message' do
      get '/arrivals/foobar'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to match(/Invalid station Stop Point ID provided/)
    end
  end

  describe 'GET /arrivals/940GZZLUGPS' do
    let(:response_body) { file_fixture('great_portland_street_arrivals.json').read }

    before do
      stub_request(:get, /api.tfl.gov.uk/)
        .with(headers: { 'Accept' => '*/*' })
        .to_return(status: 200, body: response_body)
    end

    it 'returns a working arrivals page' do
      get '/arrivals/940GZZLUGPS'

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Great Portland Street Underground Station')
      expect(response.body).to include('Eastbound - Platform 2')
      expect(response.body).to include('Westbound - Platform 1')
    end
  end
end
