defprotocol DemoProtocol do
  @fallback_to_any true
  def work(argument)
end

defimpl DemoProtocol, for: Integer do
  def work(argument) do
    argument |> IO.inspect()
  end
end

# fallback for non-implemented types
defimpl DemoProtocol, for: Any  do
  def work(argument) do
    IO.puts("Some implementation!")
  end
end

# notice we dont have to fully implement a protocol
# it will print a warning though
defimpl Enumerable, for: Integer do
  def count(_arg) do
    1
  end
end

DemoProtocol.work(42)
DemoProtocol.work([1, 2, 3])
Enumerable.count(42) |> IO.puts()
