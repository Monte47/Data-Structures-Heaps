require_relative 'heap'

def k_largest_elements(array, k)
  prc = Proc.new { |el1, el2| el2 <=> el1 }

  (1..array.length).each do |i|
    BinaryMinHeap.heapify_up(array, i - 1, i, &prc)
  end


  (array.length - 1).downto(0).each do |i|
    array[0], array[i] = array[i], array[0]
    BinaryMinHeap.heapify_down(array, 0, i, &prc)
  end

  array[array.length - k..-1]
end
