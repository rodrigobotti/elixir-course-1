# tail call is when the last thing you do in your function is call itself
# elixir/erlang optimizes tail recursive functions
defmodule ListUtils do
  
  def mult(list), do: do_mult([ 1 | list ])
  
  defp do_mult([curr | [] ]), do: curr
  defp do_mult([curr, head | tail]), do: do_mult([curr * head | tail]) # tail call!

end

defmodule Calc do
  
  def fact(a) when is_integer(a) and a > 0, do: do_fact(1, a)
  def fact(_), do: {:error, :invalid_argument}
  
  defp do_fact(res, 0), do: res
  defp do_fact(res, a), do: do_fact(res * a, a - 1)

end