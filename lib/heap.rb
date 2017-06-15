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
    @store = self.class.heapify_down(@store, 0)
  end

  def peek
    @store.first
  end

  def push(val)
  end

  public
  def self.child_indices(len, parent_index)
  end

  def self.parent_index(child_index)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
