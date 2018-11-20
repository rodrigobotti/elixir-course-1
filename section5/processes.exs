defmodule Demo do
  def work(num, index) do
    pid = spawn fn ->
      :timer.sleep(2000)
      IO.puts "[#{index}] Result is #{:rand.normal() * num}"
    end
    pid |> IO.inspect
  end

  def run(num) do
    # spawns an independent isolated process
    # if running with elixir you'll notice it wont wait for work to finish before exiting
    # when running with iex you see the output of work after the timer is passed
    # spawn fn ->
    #   # you can pass data to spawned process. it is deep copied so they share nothing
    #   work(num)
    # end

    # notice the output does not follow the sequence 1..5 as the order of execution is not guaranteed
    Enum.each 1..5, &(work(num, &1))
  end
end

# Demo.run(10) |> IO.inspect
spawn Demo, :run, [10] # passing data and choosing the function
