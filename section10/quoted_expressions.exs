# quoted expressions are ASTs which are represented as tuples in Elixir

(quote do 2 * 3 end) |> IO.inspect

(quote do elem(2, {1, 2, 3}) end) |> IO.inspect
