add wave y_in
add wave x_in
add wave add_sub
add wave func
add wave logic_func

add wave output_out
add wave overflow
add wave zero


force func 11

force x_in 0110
force y_in 1001

force logic_func 00
run 2

force logic_func 01
run 2


force x_in 1101
force y_in 1011

force logic_func 10
run 2

force logic_func 11
run 2


