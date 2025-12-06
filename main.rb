require './tree.rb'

p arr = (Array.new(15) { rand(1..100) })

tree = Tree.new(arr)

tree.build_tree

tree.pretty_print