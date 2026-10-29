add wave din
add wave reset
add wave clk
add wave write
add wave write_address
add wave read_a
add wave read_b

add wave myRegisters
add wave out_a
add wave out_b

#initialize  
force write 0
force write_address 00000
force din X"00000000"
force clk 0
force reset 0
force read_a 00001
force read_b 00010
run 2

#This register will be important for test 3
force write 1
force write_address 11011
force din X"CFFFDE09"
force clk 1 
run 2

#Lets start

force clk 0
run 2

#test 1: din enters register1 (immediate write and read with rising clk)

force din X"1FFAD01A"
force write_address 00001
force write 1
force clk 1
run 2

#test 2: din enters register 2 (wont be active until clk rises again)

force din X"1EFAD01A"
force write_address 00010
force clk 0
run 2

#test 2.5: register 2 will be modified here (synchronous write)
force clk 1
run 2

 
#test 3: read_b to register 27 shows (asynchronous operation)
force clk 0
force read_b 11011
run 2

#test 4: reset the register file (asynchronous reset)
force reset 1
run 2





