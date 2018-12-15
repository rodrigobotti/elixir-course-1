defmodule GameOfStones.Client do
  def play(stones \\ 30) do
    GameOfStones.Server.start(stones)
    start_game!()
  end

  defp start_game! do
    case GameOfStones.Server.stats() do
      {player, stones} ->
        IO.puts(
          "Welcome to the game! It's player's #{player} turn. There are #{stones} in the pile."
        )
    end

    take()
  end

  defp take do
    case GameOfStones.Server.take(ask_stones()) do
      {:next_turn, next, stones} ->
        IO.puts("\nPlayer #{next} turn. There are #{stones} left in the pile")
        take()

      {:winner, player} ->
        IO.puts("\nPlayer #{player} wins !!!")

      {:error, reason} ->
        IO.puts("Error: #{reason}")
        take()
    end
  end

  defp ask_stones do
    IO.gets("Please take from 1 to 3 stones:\n")
    |> String.trim()
    |> Integer.parse()
    |> stones_to_take()
  end

  defp stones_to_take({count, _}), do: count
  defp stones_to_take(:error), do: nil
end
