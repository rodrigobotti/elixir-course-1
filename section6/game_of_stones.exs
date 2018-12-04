defmodule Game.Client do
  def play(stones \\ 30) do
    Game.Server.start(stones)
    start_game!()
  end

  defp start_game! do
    case Game.Server.stats() do
      {player, stones} ->
        IO.puts(
          "Welcome to the game! It's player's #{player} turn. There are #{stones} in the pile."
        )
    end

    take()
  end

  defp take do
    case Game.Server.take(ask_stones()) do
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

defmodule Game.Server do
  use GenServer
  @server_name __MODULE__

  # interface

  def start(stones \\ 30) do
    GenServer.start(@server_name, stones, name: @server_name)
  end

  def stats do
    GenServer.call(@server_name, :stats)
  end

  def take(amount) do
    GenServer.call(@server_name, {:take, amount})
  end

  # callbacks

  def init(stones) when is_integer(stones) and stones > 0 do
    {:ok, {1, stones}}
  end

  def init(_) do
    {:stop, "Invalid initial number of stones"}
  end

  def handle_call(:stats, _, state) do
    {:reply, state, state}
  end

  def handle_call({:take, amount}, _, {player, stones}) do
    do_take({player, amount, stones})
  end

  def terminate(_, _) do
    # this actually runs before the client processes the :winner reply
    # it is just for demonstration purposes
    IO.puts("Thank you for playing :)")
  end

  # privates

  @error_illegal_amount "You can take 1 to 3 stones and it should be less than the total count of stones"

  defp do_take({player, amount, stones})
       when not is_integer(amount)
       when amount < 1
       when amount > 3
       when amount > stones do
    {:reply, {:error, @error_illegal_amount}, {player, stones}}
  end

  defp do_take({player, amount, stones})
       when amount == stones do
    {:stop, :normal, {:winner, next_player(player)}, {nil, 0}}
  end

  defp do_take({player, amount, stones}) do
    next = next_player(player)
    new_stones = stones - amount
    {:reply, {:next_turn, next, new_stones}, {next, new_stones}}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end

Game.Client.play(10)
