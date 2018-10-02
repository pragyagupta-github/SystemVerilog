module halfadder(
input bit a,b,
output bit s,c);
xor g1(s,a,b);
and g2(c,a,b);
endmodule