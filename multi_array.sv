module multi_array;
int arr[0:1][0:3]= '{'{1:11,default:7}, '{3:0,default:3}};
//int arr[0:1][0:3]= '{{4{'{5}}}, {4{'{3}}}};
//int arr[0:1][0:3]= '{'{7,3,5,2},'{4,8,3,7}};
//int arr[0:1][0:3]= '{2{'{7,3,5,2}}};
initial
begin
//arr[0][1]=7;
//arr[1][1]=2;
for(int i=0;i<2;i++)
 begin
 for(int j=0;j<4;j++)
 $write("arr[%0d][%0d]=%0d\t",i,j,arr[i][j]);
$display("");
end
end
endmodule
