defmodule Comp do
  require Integer

  def demo(list) do
    for el when el < 10 <- list, Integer.is_even(el), do: el * 2
  end

  def demo(l1, l2) do
    for el1 <- l1, el2 <- l2, Integer.is_even(el1), Integer.is_odd(el2),
    do: { el1, el2 }
  end

  def decipher(ciphered) do
    for << char <- ciphered >>, do: char - 1 # caesar cipher
  end

  def format_data(data) do
    for {name, age} <- data,
    into: Map.new,
    do: {format_name(name), age}
  end

  defp format_name(name), do: name |> String.downcase |> String.to_atom

end

data = %{ "Joe" => 50, "Bill" => 25, "Alice" => 23 }

Comp.format_data(data) |> IO.inspect