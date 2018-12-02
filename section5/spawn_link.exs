defmodule Demo do

  defp work_exit(false), do: exit :error
  defp work_exit(true), do: exit :normal

  def work(succeed) do
    IO.puts "doing work..."
    work_exit succeed
  end

  def run do
    # if the spawned process dies/exits the linked process will also die/exit
    # similarly, if the linked process dies (run) the spawned process will die as well
    # spawn_link fn -> work() end

    # traping exit signal from spawned process
    Process.flag :trap_exit, true
    spawn_link fn -> work(false) end

    receive do
      response -> IO.inspect response # { :EXIT, <PID_of_exited_process>, <exit_code> }
    end

    IO.puts "doing something else..."
  end

end

Demo.run
