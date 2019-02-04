defmodule Employee do
  defstruct name: "", salary: "", works_for: 0

  # without this protocol implementation IO.puts fails for the struct
  defimpl String.Chars do
    def to_string(%Employee{name: name, salary: salary}) do
      "{ name: #{name}, salary: #{salary} }"
    end
  end
end

defmodule Company do
  defstruct title: "", employees: []
  # Enumerable protocol:
  # - count/1
  # - member?/2
  # - reduce?/3
  # - slice/1
  defimpl Enumerable do
    def count(%Company{employees: employees}) do
      {:ok, Enum.count(employees)}
    end

    def member?(%Company{employees: employees}, employee) do
      {:ok, Enum.member?(employees, employee)}
    end

    def reduce(_, {:halt, result}, _fun), do: {:halted, result}
    def reduce(company, {:suspend, result}, fun) do
      {:suspeded, result, &reduce(company, &1, fun)}
    end
    def reduce(%Company{employees: []}, {:cont, result}, _fun), do: {:done, result}
    def reduce(%Company{employees: [head | tail]}, {:cont, result}, fun) do
      reduce(%Company{employees: tail}, fun.(head, result), fun)
    end

  end
end

defmodule Demo do
  def work do
    company = %Company{
      title: "Tech WAT",
      employees: [
        %Employee{name: "Thata", salary: "all the profit!", works_for: 100},
        %Employee{name: "Botti", salary: "love and care...and coffee", works_for: 99}
      ]
    }

    Enum.count(company) |> IO.inspect()

    Enum.member?(company, %Employee{
      name: "Botti",
      salary: "love and care...and coffee",
      works_for: 99
    })
    |> IO.inspect()

    Enum.reduce(company, 0, fn(employee, total_years) -> employee.works_for + total_years end) |> IO.inspect
  end
end

Demo.work()
