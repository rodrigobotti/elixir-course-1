defmodule Demo do
  def work do
    :timer.sleep 2000
    42
  end
end

worker = Task.async(fn -> Demo.work end)
IO.puts "Still doing other stuff"

answer = Task.await(worker)
IO.puts "Answer is #{answer}"
