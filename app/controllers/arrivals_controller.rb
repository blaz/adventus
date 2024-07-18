require 'tfl_arrivals'

class ArrivalsController < ApplicationController
  DEFAULT_STOP_POINT_ID = '940GZZLUGPS'.freeze # Great Portland Street

  rescue_from TflArrivals::StationNotFoundError do
    render status: :not_found, plain: 'Invalid station Stop Point ID provided'
  end

  def index
    redirect_to arrivals_path(DEFAULT_STOP_POINT_ID)
  end

  def show
    arrival_data = TflArrivals.arrivals(stop_point_id)

    if arrival_data.empty?
      render 'no_arrivals'
      return
    end

    @arrivals = ArrivalList.new(arrival_data)
    @station_name = arrival_data.first.station_name
  end

  protected

  def stop_point_id
    params[:stop_point_id]
  end
  helper_method :stop_point_id
end
