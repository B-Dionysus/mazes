#!/usr/bin/env ruby
require './cell.rb'
require 'chunky_png'

class Grid
    attr_reader :grid, :grid_array
    def initialize(rows=10, columns=10, size=30)
        @totalRows = rows
        @totalColumns = columns
        @size = size
        @grid_array = prepare_grid
        configure_cells
    end

    def prepare_grid
        Array.new(@totalRows) do |row|
            Array.new(@totalColumns) do |column|
                Cell.new(row, column, @totalRows, @totalColumns, @size)
            end
        end
    end

    def configure_cells
       each_cell do |cell|
            row, col = cell.row, cell.column
            cell.north = @grid_array[row+1][col] if ((row+1) < @totalRows)
            cell.south = @grid_array[row-1][col] if ((row-1) > 0)
            cell.west = @grid_array[row][col-1] if ((col-1) > 0)
            cell.east = @grid_array[row][col+1] if ((col+1) < @totalColumns)
            cell.front = @grid_array[row+1][0] if cell.north
       end
    end
    def each_row
        @grid_array.each do |row|
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

    def walk(cell, output)
        output+="*"
        if(cell.east) then walk(cell.east, output)
            elsif(cell.north) then walk(cell.carriage_return, output+"\n")
            else return output
        end
    end
end