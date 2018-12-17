defmodule GameOfStones.Server do
  @moduledoc """
  Game server for the Game of Stones
  """
  use GenServer, restart: :transient # if server is stoped normally, supervisor wont restart it
  @server_name __MODULE__

  # interface

  @doc """
  starts the game server.
  can set the number of stones in the start pile
  """
  def start_link(_) do
    # :started
    # :in_progress
    # :ended
    IO.puts("Game of stones server started")
    GenServer.start_link(@server_name, :started, name: @server_name)
  end

  def set_stones(stones) do
    GenServer.call(@server_name, {:set_stones, stones})
  end

  def take(amount) do
    GenServer.call(@server_name, {:take, amount})
  end

  # callbacks

  def init(:started) do
    {:ok, {1, 0, :started}}
  end

  def init(_) do
    {:stop, "Invalid initial number of stones"}
  end

  def handle_call({ :set_stones, stones }, _, { player, _, :started }) do
    {:reply, { player, stones }, { player, stones, :in_progress }}
  end

  def handle_call({:take, amount}, _, {player, stones, :in_progress}) do
    do_take({player, amount, stones})
  end

  # privates

  @error_illegal_amount "You can take 1 to 3 stones and it should be less than the total count of stones"

  defp do_take({player, amount, stones})
       when not is_integer(amount)
       when amount < 1
       when amount > 3
       when amount > stones do
    {:reply, {:error, @error_illegal_amount}, {player, stones, :in_progress}}
  end

  defp do_take({player, amount, stones})
       when amount == stones do
    {:stop, :normal, {:winner, next_player(player)}, {nil, 0, :ended}}
  end

  defp do_take({player, amount, stones}) do
    next = next_player(player)
    new_stones = stones - amount
    {:reply, {:next_turn, next, new_stones}, {next, new_stones, :in_progress}}
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end
