#!/usr/bin/env ruby
class Cell
    attr_reader :row, :column, :total_rows, :total_columns, :links, :id
    attr_accessor :north, :south, :east, :west, :front

    def initialize(row, column, grid_width, grid_height, box_size)
        @row = row
        @column = column
        @id = "R: "+row.to_s+" C: "+column.to_s
        # puts "---> " + row.to_s + " " + column.to_s
        @total_rows = grid_width
        @total_columns = grid_height
        @links = {}
    end

    def ln
        return @links.length
    end

    def link(cell, bidi=true)
    #    puts "Linking "+self.id+" to "+cell.id
        @links[cell.id] = true
        cell.link(self, false) if bidi
        self
    end
        

    def unlink(cell)
        @links[cell].delete
        cell.unlink(self)
    end
        
    def linked?(cell)
        return if cell.nil?
        puts "Cell being tested for links: " + self.id
        puts "Linked? " + cell.id.to_s + "? "+@links.to_s
        # @links.include?(cell.id) == true
        return true
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
