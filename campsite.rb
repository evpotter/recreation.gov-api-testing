class Campsite
  include Comparable

  attr :name

  def <=>(otherCampsite)
    if name.to_i.is_a? Numeric
      if otherCampsite.name.to_i.is_a? Numeric
        name.to_i <=> otherCampsite.name.to_i
      else
        return true
      end
    else
      if otherCampsite.name.to_i.is_a? Numeric
        return false
      else
        name.to_s <=> otherCampsite.name.to_s
      end
    end
  end

  def initialize(name)
    @name = name
  end
end