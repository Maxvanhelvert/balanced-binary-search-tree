require './node.rb'

class Tree
  
  def initialize(data)
    @data = data.sort.uniq
    @root = nil
  end

  def build_tree_rec(arr, first, last)
    return nil if first > last

    mid = (first + last) / 2

    root = Node.new(arr[mid])

    root.set_left(build_tree_rec(arr, first, mid - 1))
    root.set_right(build_tree_rec(arr, mid + 1, last))

    root
  end

  def build_tree
    arr = @data
    first = 0
    last = @data.length - 1
    @root = build_tree_rec(arr, first, last)
  end

  def insert(root = @root, data)
    return Node.new(data) if root.nil?
    
    if data < root.value
      root.set_left(insert(root.left_child, data))
    else
      root.set_right(insert(root.right_child, data))
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end