# Notice the separation:
# - GameServer handles game logic
# - GameClient handles user interaction

defmodule GameClient do
  def play(initial_stones_num) do
    GameServer.start initial_stones_num
    start_game!()
  end

  defp start_game! do
    send :game_server, {:info, self()}
    receive do
      {player, current_stones} ->
        IO.puts "Starting game! It's players #{player} turn.
        There are #{current_stones} stones in the pile."
    end

    take()
  end

  defp stones_to_take({count, _}), do: count
  defp stones_to_take(:error), do: nil

  defp ask_stones do
    IO.gets("\nPlease take from 1 to 3 stones:\n")
    |> String.trim
    |> Integer.parse
    |> stones_to_take
  end

  defp take do
    send :game_server, {:take, self(), ask_stones()}

    receive do
      {:next_turn, next_player, stones_count} ->
        IO.puts "\nPlayer #{next_player} turn. Stones in the pile: #{stones_count}"
        take()

      {:winner, winner} ->
        IO.puts "Player #{winner} wins!"

      {:error, reason} ->
        IO.puts "There was an error: #{reason}"
        take()

      after 5000 -> IO.puts(:stderr, "Server timeout")

    end

  end

end

defmodule GameServer do

  @error_message "Illegal move: you can take 1 to 3 stones from the pile and this number cannot exceed the total amount"

  def start(initial_stones_num \\ 30) do
    spawn(fn -> listen({1, initial_stones_num}) end)
    |> Process.register(:game_server)
  end

  defp listen({nil, 0}) do
    # rerun the game
    listen({1, 30})
    # or end the game
    # :game_end
  end

  defp listen({player, current_stones} = current_state) do
    new_state = receive do
      {:info, sender} ->
        do_info sender, current_state

      {:take, sender, num_stones} ->
        do_take({sender, player, num_stones, current_stones})

      _ -> current_state
    end

    new_state |> listen
  end

  defp do_info(sender, current_state) do
    send sender, current_state
    current_state
  end

  # error cases
  defp do_take({sender, player, num_stones_take, current_stones_count})
  when not is_integer(num_stones_take)
  when num_stones_take < 1
  when num_stones_take > 3
  when num_stones_take > current_stones_count do
    send sender, {:error, @error_message}

    {player, current_stones_count}
  end

  # win case
  defp do_take({sender, player, num_stones_take, current_stones_count})
  when num_stones_take == current_stones_count do
    send sender, {:winner, next_player(player)}

    {nil, 0}
  end

  # move case
  defp do_take({sender, player, num_stones_take, current_stones_count}) do
    new_stones_count = current_stones_count - num_stones_take
    next = next_player(player)
    send(sender, {:next_turn, next, new_stones_count})

    {player, new_stones_count}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end

GameClient.play 10
