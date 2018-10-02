module enum1;
enum {red, yellow=0, blue, green} c;
//enum {red=-1, yellow=-7, blue=0, green} c;
//enum {red=-1, yellow, blue, green} c;
//enum {red, yellow=8, blue=5, green} c;
//enum {red=5, yellow=8, blue=3, green} c;
//enum {red=5, yellow=8, blue=3, green=10} c;
//enum {red, yellow, blue, green} c;
//enum {red=5, yellow, blue, green} c;
initial
begin
c=c.first;
forever
begin
$display("%s %d",c.name, c);
if(c==c.last)
break;
c=c.next;
end
end
endmodule