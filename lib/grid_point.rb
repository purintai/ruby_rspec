class GridPoint
  attr_accessor :pos_x, :pos_y, :pos_z

  def initialize x, y, z = nil
    @pos_x = x
    @pos_y = y
    @pos_z = z
  end

  def to_s
    if @pos_z.nil?
      "(#{@pos_x}, #{@pos_y})"
    else
      "(#{@pos_x}, #{@pos_y}, #{@pos_z})"
    end
  end

  def at_same_point?(point)
    if @pos_z.nil?
      (@pos_x == point.pos_x) && (@pos_y == point.pos_y)
    else
      (@pos_x == point.pos_x) && (@pos_y == point.pos_y) && (@pos_z == point.pos_z)
    end
  end

  def is_neighbor?(point)
    if @pos_z.nil?
      ((@pos_x - point.pos_x).abs + (@pos_y - point.pos_y).abs) == 1
    else
      ((@pos_x - point.pos_x).abs + (@pos_y - point.pos_y).abs + (@pos_z - point.pos_z).abs) == 1
    end
  end
end