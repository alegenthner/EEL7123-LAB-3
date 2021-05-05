force -freeze sim:/matrixmodadd_2_2n/moduli_m1_A 00000111
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_B 00000011
run 10 ns
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_A 00000111
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_B 00000010
run 10 ns
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_A 00010000
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_B 00010000
run 10 ns
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_A 00010001
force -freeze sim:/matrixmodadd_2_2n/moduli_m1_B 00010000
run 10 ns
