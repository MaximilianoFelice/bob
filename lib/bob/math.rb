module Math

  def self.triangleRandom min: 0, max: 25
    min + (max-min)*(1 - sqrt(rand))
  end

end