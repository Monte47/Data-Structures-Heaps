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
    extraced = @store.pop
    @store = self.class.heapify_down(@store, 0, @prc)
    extraced
  end

  def peek
    @store.first
  end

  def push(val)
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
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    indices = self.child_indices(len, parent_idx)

    if indices.length == 0
      return array
    elsif indices.length == 1
      child_idx = indices[0]
    else
      child_idx = prc.call( array[indices[0]], array[indices[1]] ) == -1 ? indices[0] : indices[1]
    end

    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
    end
    self.heapify_down(array, child_idx, len, &prc)
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
