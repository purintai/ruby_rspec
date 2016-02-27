class GridPoints

  def initialize(*points)
    @points = points
  end

  def include?(point)
    @points.map{|p| point.at_same_point?(p)}.include?(true)
  end

  def connected?
    result = [0] * @points.size
    @points.each do |point|
      @points.each_with_index do |another, i|
        result[i] += 1 if point.is_neighbor?(another)
      end
    end
    !result.include?(0)
  end

  def traversable?
    result = [0] * @points.size
    @points.each_with_index do |point, i|
      result[i] = @points.map{|another| point.is_neighbor?(another)}.count(true)
    end

    return false if result.include?(0)
    return false if result.count(1) > 2
    true
  end

  def count
    @points.size
  end

end