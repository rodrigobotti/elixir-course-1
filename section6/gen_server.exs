defmodule Demo do
  use GenServer

  def start(initial_state) do
    GenServer.start(__MODULE__, initial_state)
  end

  # This callback is run when server is started
  # GenServer behaviour has a bunch of callbacks that can be implemented
  # only init is required: takes initial state and must return a tuple
  def init(initial_state) when is_number(initial_state) do
    "I am stated with state #{initial_state}"
    |> IO.puts()

    {:ok, initial_state}
  end

  def init(_) do
    {:stop, "Initial state is not a number :("}
  end
end

# Demo.start(0)
# {:ok, <PID>}
# Demo.start("")
# {:error, <reason>}
# |> IO.inspect()

case Demo.start(0) do
  {:ok, process} -> IO.inspect(process)
  {:error, reason} -> IO.puts("Error: #{reason}")
end
