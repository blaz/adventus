require 'rails_helper'

RSpec.describe ArrivalList do
  subject(:arrival_list) { described_class.new(arrivals) }

  let(:platform1_arrivals) do
    [
      double(
        'Arrival',
        line_id: 'circle',
        line_name: 'Circle',
        platform_name: "Eastbound - Platform 2",
        time_to_station: 250,
        station_name: "Great Portland Street Underground Station",
        towards: "Edgware Road (Circle)"
      ),
      double(
        'Arrival',
        line_id: 'circle',
        line_name: 'Circle',
        platform_name: "Eastbound - Platform 2",
        time_to_station: 50,
        station_name: "Great Portland Street Underground Station",
        towards: "Edgware Road (Circle)"
      )
    ]
  end

  let(:platform2_arrivals) do
    [
      double(
        'Arrival',
        line_id: 'circle',
        line_name: 'Circle',
        platform_name: "Westbound - Platform 1",
        time_to_station: 30,
        station_name: "Great Portland Street Underground Station",
        towards: "Edgware Road (Circle)"
      ),
      double(
        'Arrival',
        line_id: 'circle',
        line_name: 'Circle',
        platform_name: "Westbound - Platform 1",
        time_to_station: 567,
        station_name: "Great Portland Street Underground Station",
        towards: "Edgware Road (Circle)"
      )
    ]
  end

  let(:arrivals) { [*platform1_arrivals, *platform2_arrivals] }

  it 'returns grouped arrivals by platform' do
    expect(arrival_list.by_platform.keys).to contain_exactly('Eastbound - Platform 2', 'Westbound - Platform 1')
  end

  it 'returns sorted arrivals by time to station, earliest first' do
    expect(arrival_list.by_platform['Eastbound - Platform 2']).to match([platform1_arrivals[1], platform1_arrivals[0]])
    expect(arrival_list.by_platform['Westbound - Platform 1']).to match([platform2_arrivals[0], platform2_arrivals[1]])
  end
end
