# lists are linked lists
list = [1, "hi", :atom]
IO.puts length(list)
IO.puts Enum.at(list, 1) # iteration until position is reached

# recursive nature: lists are head + tail
# - head is the first element
# - tail is a list which contains the rest of the list
# you can recursively get the tail until you reach an empty list

IO.puts hd(list) # 1
IO.inspect tl(list) # ["hi", :atom]

# head and tail representation

IO.inspect [ 1 | [ 2, 3, 4 ] ]
IO.inspect [ 1 | [ 2 | [3, 4] ] ]

# new lists by concatenating at the head

new_list = [ "new_head" | list ] # head concatenation is inexpensive in a linked list (but last position is expensive)
IO.inspect new_list

# you can do [head | tail] pattern matching on lists
[a | b] = new_list
IO.puts a
IO.inspect b