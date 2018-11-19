defmodule Typewriter do
  
  def print_file(filename) do
    File.stream!(filename)
      |> Stream.map(&(String.replace(&1, "\n", "")))
      |> Enum.each(&print_line/1)
  end

  defp print_line(line) do
    line 
      |> String.split("")
      |> Enum.each(&print_character/1)
    IO.write("\n")
    :timer.sleep 200
  end

  def print_character(char) do
    IO.write char
    :timer.sleep 30
  end

end

Typewriter.print_file("section3/stream_file.exs")