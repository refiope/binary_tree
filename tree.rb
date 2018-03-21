#Binary Tree
class Node
  attr_accessor :data, :left, :right
  def initialize data
    @data = data
    @left = nil
    @right = nil
  end

  def no_child?
    return true if @left == nil && @right == nil
  end

  def have_two_child?
    return true if @left != nil && @right != nil
  end

  def child
    return [@left,@right]
  end
end

def build_tree array
  root_value = array.slice!(array.length / 2)
  tree = Node.new(root_value)
  array.each do |value|
    build_node(value, tree)
  end
  return tree
end

def build_node (value, current_node) #[1,2,3,4,5]
  if value < current_node.data
    if current_node.left.nil?
      current_node.left = Node.new(value)
    else
      build_node(value, current_node.left)
    end
  elsif value > current_node.data
    if current_node.right.nil?
      current_node.right = Node.new(value)
    else
      build_node(value, current_node.right)
    end
  end
end

#check data for current_node
#push the left and right pointer of current_node to queue
def breadth_first_search (value, current_queue)
  next_queue = []

  current_queue.each do |node|             #1 queue: [root]
    if node.nil?                           #2 queue: [root.left, root.right]
      next                                 #3 queue: [root.left.left ... root.right.right]
    elsif value != node.data               #4 queue: [....]
      next_queue.push(node.left)
      next_queue.push(node.right)
    else
      return node
    end
  end
  return nil if next_queue.empty?

  breadth_first_search(value, next_queue)
end

#DLR
def depth_first_search (value, tree)
  stack = [tree]
  node_with_both = []

  stack.each do |node|
    if node.data != value
      if node.have_two_child?
        node_with_both.push(node.right)
      end
      if !node.left.nil?
        stack.push(node.left)
      elsif !node.right.nil?
        stack.push(node.right)
      else
        stack.push(node_with_both.pop)
      end
    else
      return node
    end
  end
end

def dfs_rcs (value, tree)
  return tree if tree.data == value
  if !tree.left.nil?
    dfs_rcs(value, tree.left)
  end
  if !tree.right.nil?
    dfs_rcs(value, tree.right)
  end
end
