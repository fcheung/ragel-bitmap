# frozen_string_literal: true

require 'ragel/bitmap/version'

module Ragel
  # An integer bitmap that contains a width (the number of bytes that the
  # largest integer requires) and a bitmap (an integer that is the combination
  # of the element integers)
  class Bitmap
    attr_reader :width, :bitmap, :directive

    def initialize(directive, bitmap)
      @width = case directive
      when 'C' then 1
      when 'S' then 2
      when 'L' then 4
      when 'Q' then 8
      end
      @directive = directive
      @bitmap = bitmap
    end

    def [](index)
      @bitmap.byteslice(index * width, width).unpack(directive).first
    end

    def self.replace(filepath)
      require 'ragel/bitmap/replace'

      File.write(filepath, Replace.replace(File.read(filepath)))
    end
  end
end
