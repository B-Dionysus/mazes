#!/usr/bin/env ruby
require 'pry'
require './grid.rb'

g = Grid.new()
# output = g.walk(g.grid_array[0][0], "")
# puts output
origin=g.grid_array[0][1]
origin=g.grid_array[0][2]
origin.link()
# g.grid_array[0][0].link(g.grid_array[0][1])
img = g.to_png
img.save "maze.png"

        