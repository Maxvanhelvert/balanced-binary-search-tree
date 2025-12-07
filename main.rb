require './tree.rb'

# arr = (Array.new(15) { rand(1..100) })
arr = [4, 1, 79, 15, 22, 66, 52, 7, 39, 25, 24, 33, 94, 46, 54]

tree = Tree.new(arr)

tree.build_tree

tree.pretty_print

new_arr = (Array.new(15) { rand(1..100) })

new_arr.each do |value|
  tree.insert(value)
end

tree.pretty_print
