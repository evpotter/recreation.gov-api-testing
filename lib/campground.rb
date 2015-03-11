class Campground
  include Comparable

  attr :id
  attr :name
  attr :longitude
  attr :latitude

  def initialize(id, name, longitude, latitude)
    @id = id
    @name = name
    @longitude = longitude
    @latitude = latitude
  end

  def <=>(otherCampground)
    name <=> otherCampground.name
  end
end