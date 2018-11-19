# modules are namespaces for functions
# - names in camelcase
# - names can contain dots (simulate namespace hierarchy/grouping) 
# -> modules with same prefix are not related in any way, it's just for our own convenience
# - modules names are converted to atoms -> MyApp.Calc == :"Elixir.MyApp.Calc"

defmodule MyApp.Calc do 

  def plus(a, b) do
    private_fn()
    a + b # returns the last line
  end

  # in a single line
  def mult(a, b), do: a * b

  # private function
  # can be called from within the module without prefixing it with the module name
  # cannot be called from outside
  defp private_fn do
    "** private stuff **" |> IO.puts
  end

end

# pipe
MyApp.Calc.plus(1, 4) 
  |> MyApp.Calc.mult(3) # previous result (5) is passed as first argument, returning 5 * 3 which is 15
  |> IO.puts # previous result (15) is passed as first argument, prints the number


defmodule MyApp.Import do 
  import IO

  def no_prefix do
    "without prefix" |> puts # since IO is imported I no longer have to prefix it's functions
  end

end

defmodule MyApp.Alias do 
  alias IO, as: Console

  def with_alias do
    "with alias prefix" |> Console.puts # IO is renamed in the scope of this module
  end

end

defmodule MyApp.KernelUse do 

  def with_kernel do
    [1, 2, 4] 
      # length is function from the Kernel module
      # the Kernel module is implicitly imported so it doesn't need a prefix (although you can prefix it)
      |> length 
      |> IO.puts 
  end

end