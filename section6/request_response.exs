defmodule Demo do
  use GenServer

  def start(initial_state) do
    GenServer.start(__MODULE__, initial_state)

    # with a name you can ommit the pid passed as parameter for the interface methods and use the name atom
    # GenServer.start(__MODULE__, initial_state, name: :calculator)

    # you can also use the own module as the name atom
    # GenServer.start(__MODULE__, initial_state, name: __MODULE__)
  end

  def sqrt(pid) do
    GenServer.cast(pid, :sqrt)
  end

  def add(pid, number) do
    GenServer.cast(pid, {:add, number})
  end

  def result(pid) do
    # default timeout of 5 seconds -> raises error
    # can be passed as last parameter of call
    GenServer.call(pid, :result)
  end

  # -- synchronous requests --

  def handle_call(:result, _, current_state) do
    # {:reply, <response>, <new_state>}
    {:reply, current_state, current_state}
  end

  # -- asynchronous requests --

  def handle_cast(:sqrt, current_state) do
    {:noreply, :math.sqrt(current_state)}
    # {:stop, reason, new_state}
  end

  def handle_cast({:add, number}, current_state) do
    {:noreply, current_state + number}
  end

  # ------

  def terminate(reason, current_state) do
    IO.puts("TERMINATED")
    reason |> IO.inspect()
    current_state |> IO.inspect()
  end

  def init(initial_state) when is_number(initial_state) do
    "I am stated with state #{initial_state}"
    |> IO.puts()

    {:ok, initial_state}
  end

  def init(_) do
    {:stop, "Initial state is not a number :("}
  end
end

{:ok, pid} = Demo.start(4)
IO.inspect(pid)
Demo.sqrt(pid) |> IO.inspect()
Demo.result(pid) |> IO.inspect()
Demo.add(pid, 10) |> IO.inspect()
Demo.result(pid) |> IO.inspect()
