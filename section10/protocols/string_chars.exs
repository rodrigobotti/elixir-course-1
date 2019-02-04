defmodule Employee do
  defstruct name: "", salary: 0

  defimpl String.Chars do # without this protocol implementation IO.puts fails for the struct
    def to_string(%Employee{name: name, salary: salary}) do
      "{ name: #{name}, salary: #{salary} }"
    end
  end
end

defmodule Demo do
  def work do
    %Employee{name: "John", salary: 9000} |> IO.puts()
  end
end

Demo.work()
