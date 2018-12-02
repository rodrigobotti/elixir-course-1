defmodule Demo do
  def work do
    IO.puts "doing work..."
    exit :error
  end

  def run do

    # the parent process will n ot exit with the spawned process but will be notified when it exits
    # pid = spawn fn -> work() end
    # Process.monitor pid
    spawn_monitor Demo, :work, []

    receive do
      msg -> IO.inspect msg # {:DOWN, Reference, :process, <pid> }
    end

  end
end

Demo.run
