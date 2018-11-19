defmodule Streams do
  
  def transform do
    1..1_000_000
      |> Stream.map(&(&1 * 2))
      |> Stream.drop_every(3)
      |> Enum.reduce(0, &(&1 + &2))
  end

  def own_stream(factor), do: Stream.iterate(1, &(&1 * factor))

end