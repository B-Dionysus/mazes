#!/usr/bin/env ruby
class Cell
    attr_reader :row, :column, :total_rows, :total_columns 
    attr_accessor :north, :south, :east, :west, :front

    def initialize(row, column, grid_width, grid_height, box_size)
        @row = row
        @column = column
        @total_rows = grid_width
        @total_columns = grid_height
        @links = {}
    end

    def link(cell)
        @links[cell] = true
        cell.link(self)
    end

    def unlink(cell)
        @links[cell].delete
        cell.unlink(self)
    end
        
    def neighbors
        list = [];
        list << north if north
        list << south if south
        list << east if east
        list << west if west
        list
    end
    
    def carriage_return
        @north ? @front: false
    end
end
