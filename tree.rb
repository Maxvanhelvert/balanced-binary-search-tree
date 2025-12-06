require './node.rb'

class Tree
  
  def initialize(data)
    @data = data
    @root = nil
  end

  def build_tree(arr, first, last)
    return nil if first > last

    mid = (first + (last - first)) / 2

    root = Node.new(arr[mid])

    root.set_left(build_tree(arr, first, mid - 1))
    root.right_child(build_tree(arr, mid + 1, last))

    @root = root
  end
end