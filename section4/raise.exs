defmodule Demo do

  defexception message: "Demo error"

  def run do
    # raise "my own error"
    # raise ArgumentError, message: "invalid arguments"
    raise Demo, message: "other message"
  end
end

Demo.run
