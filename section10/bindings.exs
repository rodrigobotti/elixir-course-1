defmodule Demo do
  defmacro work(time) do

    some_var = "outside: I have a value"

    quoted_code = quote bind_quoted: [time: time] do # bound values are unquoted only once
      some_var = "inside: It wont be changed in here"
      time |> IO.inspect()
      :timer.sleep 1000
      time |> IO.inspect() # that means this will print the same value
      some_var |> IO.inspect()
    end
    # without binding, unquoting the values each time yields different times
    # quoted_code = quote do
    #   unquote(time) |> IO.inspect()
    #   :timer.sleep 1000
    #   unquote(time) |> IO.inspect()
    # end

    # when inspected the quoted_code:
    # with binding: os.system_time is called once and used as parameter (binding)
    # without binding: os.system_time is called twice (each unquote)
    some_var |> IO.inspect()
    quoted_code |> Macro.to_string |> IO.inspect()

    quoted_code
  end
end

defmodule Playground do
  require Demo

  def test! do
    :os.system_time() |> Demo.work()
  end
end

Playground.test!()
