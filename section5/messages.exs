defmodule Demo do
  def work do
    IO.puts("doing work...")

    # takes message from mailbox (FIFO)
    # when it matches it is processed and removed from the mailbox
    # if the message does not match it is put back in the mailbox
    # if there are no messages, receive waits indefinetely for messages to arrive
    # (unless provided with an after timeout)
    res = receive do
      # {:mult, a, b} -> a * b
      # {:message, value} -> value
      # _ -> "???"
      { sender, { a, b } } -> send(sender, a * b)
    after 5000 -> IO.puts "Waited long enough..."
    end

    IO.puts "Message result: #{res}"

  end

  def run(message) do
    pid = spawn fn ->
      work()
    end

    send pid, { self(), message }
    # you can send messages to the same process
    # to get the current PID, call `self()`

    receive do
      response -> IO.puts("Response is #{response}")
    end

  end

end
