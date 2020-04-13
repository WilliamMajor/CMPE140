ori 	$a0, 5 #  n
sw	$a0, 0
ori	$s0, 1 # f
wloop:
blt	$a0, 1, exit # while (n > 1)
mult	$s0, $a0
mflo	$s0
subi 	$a0, $a0, 1
j	wloop
exit:
sw	$s0, 0x10
