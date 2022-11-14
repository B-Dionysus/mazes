#!/usr/bin/env ruby
require './cell.rb'
require 'chunky_png'

class Grid
    attr_reader :grid, :grid_array
    def initialize(rows=10, columns=10, size=30)
        @totalRows = rows
        @totalColumns = columns
        @size = size
        @grid_array = []
        prepare_grid
        configure_cells
    end

    def to_png
        img_width = @totalRows * @size
        img_height = @totalColumns * @size
        background = ChunkyPNG::Color::WHITE
        wall = ChunkyPNG::Color::BLACK

        target = @grid_array[2][0].west.west
        # puts target.row.to_s + " " + target.column.to_s
        img = ChunkyPNG::Image.new(img_width+1, img_height+1, background)
        centerC = target.column*@size + (@size/2)
        centerR = target.row*@size + (@size/2)
        img[centerR, centerC] = ChunkyPNG::Color.rgba(255, 0,0, 128)

        each_cell do |cell|
            x1 = cell.column * @size
            x2 = (cell.column + 1) * @size
            y1 = cell.row * @size
            y2 = (cell.row + 1) * @size
            puts cell.row.to_s + " " + cell.column.to_s
            puts cell.links
            img.line(x1, y1, x2, y1, wall) unless cell.linked?(cell.north)
            img.line(x1, y1, x1, y2, wall) unless cell.linked?(cell.west)
            img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
            img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
            # img.line(x1, y1, x2, y1, wall) unless cell.north
            # img.line(x1, y1, x1, y2, wall) unless cell.west
            # img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
            # img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
        end
        img
    end
    def prepare_grid
        # Array.new(@totalRows) do |row|
        #     Array.new(@totalColumns) do |column|
        #         Cell.new(row, column, @totalRows, @totalColumns, @size)
        #     end
        # end
        for i in 0..@totalRows do
            row_array = []
            for j in 0..@totalColumns do
                # puts i.to_s + " " + j.to_s
                row_array.push Cell.new(i, j, @totalRows, @totalColumns, @size)
            end
            @grid_array.push row_array
        end
    end

    def configure_cells
       each_cell do |cell|
            row, col = cell.row, cell.column
            # cell.east = @grid_array[row+1][col] if ((row+1) < @totalRows)
            # cell.south = @grid_array[row][col+1] if ((col+1) < @totalColumns)
            # cell.west = @grid_array[row-1][col] if ((row-1) > 0)
            # cell.north = @grid_array[row][col-1] if ((col-1) > 0)
            
            # cell.front = @grid_array[row+1][0] if cell.east
            cell.north = @grid_array[row][col-1] if ((col-1) >= 0)
            cell.south = @grid_array[row][col+1] if ((col+1) < @totalColumns)
            cell.west = @grid_array[row-1][col] if ((row-1) >= 0)
            cell.east = @grid_array[row+1][col] if ((row+1) < @totalRows)
            cell.front = @grid_array[0][col-1] if cell.north
       end
    end
    def each_row
        @grid_array.each do |row|
            yield row
        end
    end

    def each_cell
        for row_array in @grid_array do
            for cell in row_array do
                yield cell
            end
        end
        # each_row do |row|
        #     row.each do |cell|
        #         yield cell
        #     end
        # end
    end

    def walk(cell)
        # pry
        binaryLink(cell)
        if cell.east&.column then walk(cell.east)
        elsif cell.north&.column then walk(cell.carriage_return)
        else return
        end
        # i=0        
        # until i>=99 do
        #     binaryLink(@grid_array[0][i])
        #     i=i+1
        # end
    end

    def binaryLink(cell)
        if cell.north.nil?
            return if cell.east.nil?
# puts cell.row.to_s + " " + cell.column.to_s
            cell.link(cell.east)
            return

        elsif cell.east.nil?
            cell.link(cell.north) 
        else
            link_eastern_cell = Random.new.rand(100)>50
            link_eastern_cell ? cell.link(cell.east) : cell.link(cell.north)
        end
    end
end