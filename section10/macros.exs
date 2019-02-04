# Macros
# special forms that return quoted code
# - parameters passed to macro are also represented as quoted code
# - macros are processed before the program is executed

defmodule Demo do
  defmacro work(argument) do
    quote do
      # argument * 10 # fails because argument is quoted code
      unquote(argument) * 10
    end
  end


  def palindrome?(str, expr) do
    if str == String.reverse(str) do
      expr
    end
  end

  defmacro macro_palindrome?(str, expr) do
    quote do
      if(unquote(str) == String.reverse(unquote(str))) do
        unquote(expr)
      end
    end
  end

end

defmodule Playground do
  require Demo

  def test! do
    # Demo.palindrome?("whatever", IO.puts("found one!")) # always prints "found one" because the expression is executed on invocation
    Demo.macro_palindrome?("asdasdasd", IO.puts("found one!"))
  end

end

Playground.test!()
