require './tree.rb'

p arr = (Array.new(15) { rand(1..100) })

tree = Tree.new(arr)

tree.build_tree

tree.pretty_print

p tree.insert(45)
p tree.insert(83)
p tree.insert(7)

tree.pretty_print