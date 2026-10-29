add wave x_in
add wave y_in

add wave add_sub
add wave func
add wave logic_func

add wave output_out
add wave overflow
add wave zero

force add_sub 0
force logic_func 00

#Part 1 : test y change
force x_in 10#165

force func 00

force y_in 10#169
run 2

force y_in 10#10
run 2

force y_in 10#19265
run 2

#Part 2: test less than

force func 01

force x_in 10#100
force y_in 10#50
run 2

force x_in 10#100
force y_in 10#150
run 2
 
force x_in 10#100
force y_in 10#100
run 2


#Part 3 test add_sub

force func 10

force x_in 10#150
force y_in 10#66
run 2

force x_in 16#FFFFFFFF
force y_in 10#2
run 2

force add_sub 1
force x_in 10#150
force y_in 10#150
run 2

force x_in 10#150
force y_in 10#250
run 2

#part 4 test 
force func 11



force x_in 16#00000006
force y_in 16#00000009

force logic_func 00
run 2

force logic_func 01
run 2


force x_in 16#0000000D
force y_in 16#0000000B

force logic_func 10
run 2

force logic_func 11
run 2


