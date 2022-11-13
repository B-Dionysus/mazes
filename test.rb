#!/usr/bin/env ruby
require 'pry'
require './grid.rb'

g = Grid.new()
output = g.walk(g.grid_array[0][0], "")
puts output


        