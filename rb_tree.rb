# A class for a tree data structure.
class Tree
  attr_accessor :root
  
  # A class for a node with references to the parent and children.
  class Node
    attr_accessor :id, :value, :parent, :children
    
    # Initializes a node with an id, value, and pointer to the parent.
    def initialize(id, value, parent)
      @id = id
      @value = value
      @parent = parent
      @children = []
    end

    # Removes all children and links to descendants.
    def abandon
      @children.clear
    end
    
    # Adds a child to this node.
    def birth(id, value, index = @children.size)
      temp = Node.new(format("%s/%s", @id.to_s, id.to_s), value, self)
      @children.insert(index, temp)
      return temp
    end
    
    # Gets the child at the index.
    def get(index)
      @children[index]
    end
    
    # Returns the index of this node in the parent's children array.
    def index
      @parent.children.index(self)
    end
    
    # Indicates whether this node is the first sibling.
    def is_first_sibling?
      return true if is_root?
      index == 0
    end
    
    # Indicates whether this node is the last sibling.
    def is_last_sibling?
      return true if is_root?
      index == @parent.children.size - 1
    end

    # Indicates whether this node is a leaf.
    def is_leaf?
      @children.empty?
    end

    # Indicates whether this node is the root.
    def is_root?
      @parent.nil?
    end

    # Returns the parental lineage of this node, starting with the root.
    def lineage
      return nil if is_root?

      lineage = []
      temp = self
      while temp
        lineage.unshift(temp)
        temp = temp.parent
      end
      return lineage
    end

    # Removes this node's child at index.
    def lose_child_index(index)
      temp = @children.slice!(index)
      @children.insert(index, temp.children)
      @children.flatten!
      temp.children.each { |child| child.parent = self }
      @children.compact!
      return temp
    end

    # Removes this node's children with id.
    def lose_child_id(id)
      temp = @children.select { |child| child.id == id }
      temp.each { |match| lose_child_index(match.index) }
    end

    # Removes this node's children with value.
    def lose_child_value(value)
      temp = @children.select { |child| child.value == value }
      temp.each { |match| lose_child_index(match.index) }
    end
    
    # Returns this node's next sibling (right sibling).
    def sibling_next
      @parent.get(index + 1) unless is_last_sibling?
    end
    
    # Returns this node's prev sibling (left sibling).
    def sibling_prev
      @parent.get(index - 1) unless is_first_sibling?
    end

    # Returns the root node of this node's tree.
    def progenitor
      return self if is_root?

      temp = @parent
      while temp.parent
        temp = temp.parent
      end
      return temp
    end

    # Returns a string representation of the node.
    def to_s
      str = format("ID: %s, Value: %s", @id, @value.to_s)
    end
  end

  # A class for a post-order tree traversal algorithm.
  class PostOrderIterator
    attr_accessor :stack
    
    # Initializes an iterator with the root of the tree to traverse.
    def initialize(tree)
      @stack = Array.new
      push_left(tree.root)
    end
    
    # Indicates whether there are more nodes to be explored.
    def has_next?
      !@stack.empty?
    end

    # Returns the value of the next node to be explored.
    def next
      while has_next?
        current = @stack.pop
        if !current.is_last_sibling?
          push_left(current.sibling_next)
        end
        return current
      end
    end
    
    # Pushes the node and its leftmost line of descendants.
    def push_left(node)
      while node
        @stack.push(node)
        node = node.get(0)
      end
    end
  end

  # Initializes a tree with a root.
  def initialize(value)
    @root = Node.new("~", value, nil)
  end
  
  # Adds a node at the specified location.
  def add(parent, id, value, index = parent.children.size)
    parent.birth(id, value, index) if parent
  end
  
  # Returns the node at the specified location, relative to the root.
  def get(*index)
    temp = @root
    index.each { |level| temp = temp.get(level) }
    return temp
  end
  
  # Returns a post-order iterator for this tree.
  def post_order_iterator
    PostOrderIterator.new(self)
  end
  
  # Returns a string representation of the tree with nodes in BFS order.
  def to_s
    str = ""
    queue = Array[@root]
    while !queue.empty?
      temp = queue.shift
      str += format("%s\n", temp.to_s)
      temp.children.each { |child| queue.push(child) }
    end
    str.rstrip!
  end
end
