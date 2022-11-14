#!/usr/bin/env ruby
require 'pry'
require './grid.rb'

g = Grid.new(4,4)

origin=g.grid_array[0][0]
puts origin.row
puts origin.east.nil?
g.walk(origin)
puts "------"
puts origin.linked?(origin.east)
puts "------"
# g.grid_array[0][0].link(g.grid_array[0][1])
img = g.to_png
img.save "maze.png"

        