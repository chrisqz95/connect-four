# A class for a tree data structure.
class Tree
  attr_accessor :root
  
  # A class for a node with references to the parent and children.
  class Node
    attr_accessor :data, :parent, :children
    # Initializes a node with data and a pointer to the parent.
    def initialize(data, parent)
      @data = data
      @parent = parent
      @children = []
    end

    # Returns a string representation of the Node.
    def to_s
      return @data.to_s
    end
  end

  # Initializes a tree with root data.
  def initialize(data)
    @root = Node.new(data, nil)
  end

  # Adds data under the specified parent node.
  def add(data, parent)
    temp = Node.new(data, parent)
    parent.children.push(temp)
  end
end
