class TflArrivals
  Error = Class.new(StandardError)
  ClientError = Class.new(Error)
  StationNotFoundError = Class.new(Error)

  def self.arrivals(stop_point_id)
    new(stop_point_id).arrivals
  end

  def initialize(stop_point_id)
    @client = Client.new
    @stop_point_id = stop_point_id
  end

  def arrivals
    client.arrivals(stop_point_id).map { Arrival.new(_1) }
  end

  private

  attr_reader :client, :stop_point_id

  class Arrival
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def platform_name
      data['platformName']
    end

    def station_name
      data['stationName']
    end

    def time_to_station
      data['timeToStation']
    end

    def line_name
      data['lineName']
    end

    def line_id
      data['lineId']
    end

    def towards
      data['towards']
    end
  end

  class Client
    API_BASE_URL = 'https://api.tfl.gov.uk/'.freeze

    def arrivals(stop_point_id)
      arrivals_api_url = "#{API_BASE_URL}/stoppoint/#{stop_point_id}/Arrivals"
      result = Net::HTTP.get_response(URI(arrivals_api_url))

      raise StationNotFoundError, "Invalid station StopPointId" if result.code.to_i == 404
      raise ClientError, "Unhandled status code: #{result.status}" if result.code.to_i != 200

      JSON.parse(result.body)
    end
  end
end
