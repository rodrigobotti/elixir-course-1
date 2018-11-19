defmodule Cond do
  def run(str) do
    len = String.length str
    cond do
      len > 0 and len < 5 -> "short"
      len >= 5 and len < 10 -> "medium"
      len > 10 -> "long"
      true -> "empty" # fallback clause
    end
  end
end

defmodule Case do
  def run(argv) do
    parsed_args = OptionParser.parse(argv, switches: [ debug: :boolean ])
    case Keyword.fetch(elem(parsed_args, 0), :debug) do
      {:ok, true} -> "debug mode on!"
      {:ok, false} -> "debug mode off!"
      _ -> "Debug option not set!" # fallback clause
    end
  end
end

Case.run(System.argv) |> IO.inspect