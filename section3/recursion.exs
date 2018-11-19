defmodule ListUtils do
  
  def mult([]), do: 1
  def mult([ head | [] ]), do: head
  def mult([ head | tail ]), do: head * mult(tail)

  def map([], _mapper), do: []
  def map([head | tail], mapper), do: [ mapper.(head) | map(tail, mapper) ]

  def filter([], _predicate), do: []
  def filter([head | tail], predicate) do
    if predicate.(head) do
      [ head | filter(tail, predicate) ]
    else
      filter(tail, predicate)
    end
  end 

  def max([]), do: nil
  def max([ current_max ]), do: current_max
  def max([ current_max, next | tail ]) when current_max >= next, do: max [ current_max | tail ]
  def max([ head, current_max | tail ]) when head < current_max, do: max [ current_max | tail ]

  def reduce(list, initial, accumulator), do: do_reduce([ initial | list ], accumulator)
  defp do_reduce([ acc, curr | [] ], accumulator), do: accumulator.(acc, curr)
  defp do_reduce([ acc, curr | tail ], accumulator), do: do_reduce([ accumulator.(acc, curr) | tail ], accumulator)

end