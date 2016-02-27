class GridPoints

  def initialize(*points)
    @points = points
  end

  def include?(point)
    @points.map{|p| point.at_same_point?(p)}.include?(true)
  end

  def connected?
    if @points.size == 2
      @points[0].is_neighbor?(@points[1])
    elsif @points.size == 3
      if @points[0].is_neighbor?(@points[1])
       @points[1].is_neighbor?(@points[2]) or @points[0].is_neighbor?(@points[2])
     else
       @points[0].is_neighbor?(@points[2]) and @points[1].is_neighbor?(@points[2])
      end
    elsif @points.size == 4
      # TODO
      result = [0] * @points.size
      result[0] = 2
      @points.each_with_index do |point, i|
        if @points[0].is_neighbor?(point)
          result[i] += 1
        end
      end
    end
  end

  def count
    @points.size
  end

end