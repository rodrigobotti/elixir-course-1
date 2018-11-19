defmodule Calc do
  # add/1
  def add(a) do
    add a, 0
  end
  
  # add/2
  def add(a, b) do
    a + b
  end
  
  # def add(a, b \\ 0) do
  #   a + b
  # end

  def divide(_a, 0) do
    {:error, "dividing by zero"}
  end

  def divide(a, b) do
    a / b
  end
  
  # remember that pattern matching is top to bottom
  # so rule of thumb is, put the more specific functions first
  
  def factorial(0), do: 1

  def factorial(a) when is_integer(a) and a > 0 do
    a * factorial(a - 1)
  end

  def factorial(_), do: {:error, :invalid_argument}

end