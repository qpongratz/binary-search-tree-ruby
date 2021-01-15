# frozen_string_literal: true

require_relative 'node'

# A binary search tree
class Tree
  attr_reader :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(0, (@array.length - 1))
  end

  def build_tree(start_pos, end_pos)
    return nil if start_pos > end_pos

    middle = (start_pos + end_pos) / 2
    root = Node.new(@array[middle])
    root.left = build_tree(start_pos, (middle - 1))
    root.right = build_tree((middle + 1), end_pos)
    root
  end

  def insert(value)
    current_node = @root
    until current_node.value == value
      if value < current_node.value
        return current_node.left = Node.new(value) if current_node.left.nil?

        current_node = current_node.left
      elsif value > current_node.value 
        return current_node.right = Node.new(value) if current_node.right.nil?

        current_node = current_node.right
      end
    end
  end

  def find(value)
    current_node = @root
    until current_node.nil? || value == current_node.value
      current_node = (value < current_node.value ? current_node.left : current_node.right)
    end
    current_node
  end

  def level_order(queue = [], node_list = [], current_node = @root)
    return nil if queue.empty? && current_node.nil?

    unless current_node.nil?
      queue.push(current_node.left).push(current_node.right)
      node_list.push(current_node.value)
    end
    current_node = queue.shift
    level_order(queue, node_list, current_node)
    node_list
  end

  def height(node = @root)
    return -1 if node.nil?

    left = height(node.left)
    right = height(node.right)
    (left > right ? left + 1 : right + 1)
  end

  def depth(node)
    count = 0
    value = node.value
    current_node = @root
    until current_node == node || current_node.nil?
      count += 1
      current_node = (value < current_node.value ? current_node.left : current_node.right)
    end
    current_node.nil? ? nil : count
  end

  def balanced?(node = @root)
    return true if node.nil?

    (height(node.left) - height(node.right)).between?(-1, 1) &&
      balanced?(node.left) &&
      balanced?(node.right)
  end

  def rebalance
    @array = level_order
    @root = build_tree(0, (@array.length - 1))
  end


  def inorder(current_node = @root, node_list = [])
    return nil if current_node.nil?

    inorder(current_node.left, node_list)
    node_list.push(current_node.value)
    inorder(current_node.right, node_list)
    node_list
  end

  def postorder(current_node = @root, node_list = [])
    return nil if current_node.nil?

    postorder(current_node.left, node_list)
    postorder(current_node.right, node_list)
    node_list.push(current_node.value)
    node_list
  end

  def preorder(current_node = @root, node_list = [])
    return nil if current_node.nil?

    node_list.push(current_node.value)
    preorder(current_node.left, node_list)
    preorder(current_node.right, node_list)
    node_list
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

random_array = []
(1..50).each { |n| random_array << n }

new_tree = Tree.new(random_array)
new_tree.pretty_print
thirteen = new_tree.find(13)
(60..69).each { |n| new_tree.insert(n) }
p new_tree.height(thirteen)
p new_tree.height
p new_tree.depth(thirteen)
new_tree.pretty_print
