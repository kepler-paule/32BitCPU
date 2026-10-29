add wave x_in
add wave y_in

add wave add_sub
add wave func
add wave logic_func

add wave output_out
add wave overflow
add wave zero

force logic_func 01

force x_in 0100
force y_in 0100
force add_sub 1
force func 10 
run 2

force x_in 1111
force y_in 0010
force add_sub 0
 
run 2

force x_in 0011
force y_in 0101
force add_sub 0
 
run 2

force x_in 0111
force y_in 0110
force add_sub 1

run 2

force func 01
force y_in 1101
run 2

force y_in 0101
run 2

force x_in 1111
force y_in 0001
run 2

