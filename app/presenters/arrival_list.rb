class ArrivalList
  SHOW_ONLY = 10

  def initialize(arrivals)
    @arrivals = arrivals
  end

  def by_platform
    arrivals.group_by(&:platform_name).each_value do |platform_arrivals|
      platform_arrivals.sort_by!(&:time_to_station).slice!(SHOW_ONLY..-1)
    end
  end

  private

  attr_reader :arrivals
end
