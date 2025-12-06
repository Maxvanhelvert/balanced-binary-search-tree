class Node

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end

  def set_left(child)
    @left_child = child
  end

  def set_right(child)
    @right_child = child
  end
end