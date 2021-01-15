# frozen_string_literal: true

# Controls what a node is and what it can do.
class Node
  include Comparable

  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def to_s
    @value.to_s
  end
end
