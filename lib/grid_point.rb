class GridPoint
  attr_accessor :pos_x, :pos_y

  def initialize x, y
    @pos_x = x
    @pos_y = y
  end

  def to_s
    "(#{@pos_x}, #{@pos_y})"
  end

  def at_same_point?(point)
    (@pos_x == point.pos_x) && (@pos_y == point.pos_y)
  end

  def is_neighbor?(point)
    ((@pos_x - point.pos_x).abs + (@pos_y - point.pos_y).abs) == 1
  end
end