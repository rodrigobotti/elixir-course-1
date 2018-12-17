defmodule Storage do
  @name {:global, :storage}

  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def store(result, number) do
    Agent.update(@name, &Map.merge(&1, %{number => result}))
  end

  def get_all do
    Agent.get @name, &(&1)
  end

  def get(number) do
    Map.get get_all(), number
  end

end

defmodule Factorial do
  def products_of(numbers) do
    numbers
    |> Stream.map(&(Task.async(fn -> fact(&1) end)))
    |> Enum.map(&(Task.await/1))
  end

  defp fact(number) do
    do_fact(1, number) |> Storage.store(number)
  end

  defp do_fact(result, 0), do: result
  defp do_fact(result, a) do
    result * a |> do_fact(a - 1)
  end

end

# Running
# open 2 terminals
# 1: iex --sname node1 section9/storage.exs
# 2: iex --sname node1 section9/storage.exs
# 1: iex(node1@<system>)> Node.connect :"node2@<system>"
# 1: iex(node1@<system>)> Node.list
# 2: iex(node2@<system>)> Storage.start_link
# 2: iex(node2@<system>)> Node.list
# 1: iex(node1@<system>)> Factorial.products_of 1..10
# 2: iex(node2@<system>)> Factorial.products_of 11..20
# 1: iex(node1@<system>)> Storage.get_all
# 2: iex(node2@<system>)> Storage.get_all
