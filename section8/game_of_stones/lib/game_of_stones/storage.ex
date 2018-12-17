defmodule GameOfStones.Storage do
  use GenServer, restart: :transient

  @server_name __MODULE__
  @ets_name :storage

  # interface

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @server_name)
  end

  def store(data) do
    GenServer.call(@server_name, {:store, data})
  end

  def fetch_all do
    GenServer.call(@server_name, :fetch_all)
  end

  def fetch do
    GenServer.call(@server_name, :fetch)
  end

  # callbacks

  def init(_) do
    :ets.new(@ets_name, [:ordered_set, :private, :named_table, {:keypos, 2}])
    {:ok, nil}
  end

  def handle_call({:store, {:winner, _}}, _, _current) do
    :ets.delete_all_objects(@ets_name)
    {:reply, nil, nil}
  end

  def handle_call({:store, data}, _, _current) do
    :ets.insert(@ets_name, data)
    {:reply, data, data}
  end

  def handle_call(:fetch_all, _, current) do
    { :reply, :ets.tab2list(@ets_name), current }
  end

  def handle_call(:fetch, _, current) do
    {:reply, current, current}
  end
end
