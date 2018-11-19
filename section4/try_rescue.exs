defmodule Demo do
  def run do
    try do
      Keyword.fetch!([a: 6], :a)
    rescue
      # e in KeyError -> e # for when you need access to error that was raised
      KeyError -> IO.puts "key cannot be found"
      ArgumentError -> "invalid arguments"
    after # finally
      IO.puts "executed no matter what"
    else 
      # takes the value returned from the try block and matches against the clauses
      # executed only if there were no errors
      5 -> "found five"
      _ -> "found whatever"
    end
  end
end

Demo.run |> IO.inspect