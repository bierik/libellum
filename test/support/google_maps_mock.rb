class GoogleMapsMock
  def initialize(*); end

  def distance
    OpenStruct.new(value: 3000)
  end
end
