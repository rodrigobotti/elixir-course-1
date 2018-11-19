# atoms are stored in an atom table
:ok == :"ok"
:error
result = :ok # result contains reference to the atom table not the actual atom itself

# booleans do not exist -> sintatic sugar for atoms
true == :true
false == :false

# nil is also an atom (behaves similarly to null of other languages)
nil == :nil

# falsy values
nil
false

# truthy values -> everything else