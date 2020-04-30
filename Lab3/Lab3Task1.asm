ori	$a0, $0, 0x8000
ori	$a1, $0, 0x00A9
ori	$s0, $0, 0x07B6 #1974
sll	$a0, $a0, 15
sw	$s1, 0x20
mult	$s1, $a1
mflo	$s2
mfhi	$s3
sw	$s3, 0x24
sw	$s2, 0x28
srl	$s2, $s2, 16
add	$a3, $s0, $s2
div	$a3, $a3, 0x7B6 # original content of s0
srl	$s0, $a3, 1
sw	$s0, 0x2C
wloop:
blt	$s0, 1665, next
add	$s3, $s0, $s2
div	$s3, $s3, $s0
srl	$s0, $s3, 1
j	wloop
next:
sll	$s0, $s0, 8
sw	$s0, 0x30
