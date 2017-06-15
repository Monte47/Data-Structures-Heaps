class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    self.class.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    indices = []
    left_child_index = (parent_index * 2) + 1
    right_child_index = (parent_index * 2) + 2
    indices << left_child_index if left_child_index < len
    indices << right_child_index if right_child_index < len
    indices
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    children_indices = self.child_indices(len, parent_idx)

    if children_indices.length == 0
      return array
    elsif children_indices.length == 1
      child_idx = children_indices[0]
    else
      if prc.call( array[children_indices[0]], array[children_indices[1]] ) == 1
        child_idx = children_indices[1]
      else
        child_idx = children_indices[0]
      end
    end

    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
    end

    self.heapify_down(array, child_idx, len, &prc)
    array

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0

    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    parent_idx = self.parent_index(child_idx)

    if prc.call(array[child_idx],array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
    end

    self.heapify_up(array, parent_idx, len, &prc)
    array

  end
end
