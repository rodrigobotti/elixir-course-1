# there is no string type per-se
# there is only binary data and list of characters

# *** binary ***

string = "Hi!"
# for literal binary data: << 1, 1000 >>

string = "hi #{2 * 5}"
IO.inspect string
s_sigil = ~s(hi #{2 * 5})
no_interpolation_sigil = ~S(hi #{2*5})
IO.inspect s_sigil
IO.inspect no_interpolation_sigil

IO.inspect s_sigil <> no_interpolation_sigil

# *** character lists ***

list = 'HI'
IO.inspect list
IO.inspect [72, 73] # > 'HI' -> elixir tries to guess if all elements are characters. in this case it will output as characters
list_sigil = ~c(hi #{2*3})
IO.inspect list_sigil
IO.inspect ~C(hi #{2*5}) # no interpolation

# ** recommendation **: avoid character lists unless necessary (e.g. some third-party library for erlang that only supports this data type)

"HI" != 'HI'
"HI" == List.to_string('HI')
'HI' == String.to_charlist("HI")