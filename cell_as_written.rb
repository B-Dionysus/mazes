Module Cell
    Class Cell
        attr_reader :row, :column
        attr_accessor :north, :south, :east, :west

        def initialize(row, column)
            @row, @column = row, column
            @links = {}
        end

        def link(cell, bidirectional = true)
            @links[cell] = true
            cell.link(self, false) if bidirectional
        end

        def unlink(cell, bidirectional = true)
            @links.delete(cell)
            cell.unlink(self, false) if bidirectional
            self
        end

        def links
            @links.keys
        end

        def linked?(cell)
            @links.key?(cell)
        end