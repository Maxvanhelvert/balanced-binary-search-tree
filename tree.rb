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

  def delete(root = @root, data)
    return root if root.nil?

    if root.value > data
      root.set_left(delete(root.left_child, data))
    elsif root.value < data
      root.set_right(delete(root.right_child, data))
    else
      return root.right_child if root.left_child.nil?
      return root.left_child if root.right_child.nil?

      succ = get_successor(root)
      root.set_value(succ.value)
      root.set_right(delete(root.right_child, succ.value))
    end

    root
  end

  def get_successor(node)
    node = node.right_child

    while !node.nil? and !node.left_child.nil?
      node = node.left_child
    end

    node
  end

  def find(root = @root, value)
    return nil if root.nil?

    if value > root.value
      root = find(root.right_child, value)
    elsif value < root.value
      root = find(root.left_child, value)
    else
      return root
    end
    
    root
  end

  def level_order
    root = @root
    return if root.nil?

    q = []
    res = []
    
    q.append(root)
    level = 0

    while q.length > 0
      q_len = q.length
      res.append([])

      for _each in 1..q_len do
        node = q.shift
        yield node.value
        res[level].append(node.value)

        q.append(node.left_child) unless node.left_child.nil?
        q.append(node.right_child) unless node.right_child.nil?
      end
      level += 1
    end

    res
  end

  def in_order
    current = @root
    res = []
    stack = []

    while !current.nil? || stack.length > 0
      until current.nil?
        stack.append(current)
        current = current.left_child
      end

      current = stack.pop
      yield current.value if block_given?
      res.append(current.value)
      current = current.right_child
    end

    res
  end

  def pre_order
    current = @root
    res = []
    stack = []

    while !current.nil? || stack.length > 0
      until current.nil?
        yield current.value if block_given?
        res.append(current.value)

        stack.append(current)
        current = current.left_child
      end


      current = stack.pop
      current = current.right_child
    end

    res
  end

  def post_order
    current = @root
    res = []
    return res if current.nil?

    stack = []
    last_visited = nil
    
    until stack.empty? and current.nil?
      if !current.nil?
        stack.append(current)
        current = current.left_child
      else
        peek = stack[-1]
        if peek.right_child and last_visited != peek.right_child
          current = peek.right_child
        else
          res.append(peek.value)
          yield peek.value if block_given?
          last_visited = stack.pop
        end
      end
    end

    res
  end
  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end