value = %{ "language" => "Elixir", "platform" => "Eduonix" }
value = %{ language: "Elixir", platform: "Eduonix" }
# best practice is to use atoms as keys for faster access and comparison
IO.puts value[:language]
IO.puts value.platform
IO.inspect value[:non_existent] # nil
# IO.inspect value.non_existent # -> (KeyError) key :non_existent not found in: %{language: "Elixir", platform: "Eduonix"}
new_value = %{ value | language: "Erlang", platform: "IDK" }
IO.inspect new_value
# new_value = %{ value | wat: "WAT" } # -> ** (KeyError) key :wat not found

# maps used to not be performant in older versions of Elixir
# so some old literature might recommend the usage of modules such as `dict` or `hash dict` which are now deprecated

# note, btw, that maps do not allow duplicate keys in contrast to keyword lists