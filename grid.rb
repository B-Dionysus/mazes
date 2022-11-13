#!/usr/bin/env ruby
require './cell.rb'
class Grid
    attr_reader :grid
    def initialize(rows=10, columns=10, size=30)
        @rows = rows
        @columns = columns
        @size = size
        @grid = prepare_grid
        configure_cells
    end

    def prepare_grid
        Array.new(@rows) do |row|
            Array.new(@columns) do |column|
                Cell.new(row, column, @rows, @columns, @size)
            end
        end
    end

    def configure_cells
        each_cell do |cell|
            col = cell.column
            row = cell.row

            # cell.north = @grid[row+1][col]
            # puts cell.north.column
        end
    end

    def each_row
        @grid.each do |row|
            yield row
        end
    end

    def each_cell
        each_row do |row|
            row.each do |cell|
                yield cell
            end
        end
    end

end