mad_printer = fn str ->
  str
    |> String.reverse
    |> IO.puts
end

mad_printer_2 = &(
  &1
    |> String.reverse
    |> IO.puts
)

salt = "RANDOM"

printer_closure = fn str ->
  str <> salt
    |> String.reverse
    |> IO.puts
end
# salt = "NEW RANDOM" # if salt is rebound after the function definition it will not change the value in the closure

print_factory = fn rand ->
  fn str ->
    str <> rand
      |> String.reverse
      |> IO.puts
  end
end

multi_print = fn
  "" -> IO.puts "no value"
  str -> mad_printer.(str)
end

Enum.each ["hello", "there", "friend"], mad_printer
Enum.each ["hello", "there", "friend"], mad_printer_2

Enum.each ["hello", "there", "friend"], &IO.puts/1
Enum.each ["hello", "there", "friend"], &(IO.puts &1)

Enum.each ["a", "b", "c"], print_factory.("salt")

Enum.each ["a", "b", "c", "", "e"], multi_print

# mad_printer.("hello there my friend!")