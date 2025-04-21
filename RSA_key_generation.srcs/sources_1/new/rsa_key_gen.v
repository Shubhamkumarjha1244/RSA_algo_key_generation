`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Patna
// Engineer: Shubham Kumar Jha(2411EE22),Alok Ranjan(2411EE12),Rohit Raj(2411EE05)
// (under supervision of PROF. Jawar Singh)
// Create Date: 17.04.2025 09:07:46
// Design Name: 
// Module Name: rsa_key_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//Prime number Generator Block
//////////////////////////////////////////////////////////////////////
module prbs_16bit(clk,sel,out);
        input clk;
        input[2:0] sel;
        output reg[15:0] out=0;
        always @(clk)
        case (sel)
            2'b000:
                begin
                out<=out>>1;
                out[15]<=(out[1])~^(out[0]);
                end
            2'b001:
                begin
                out<=out<<1;
                out[0]<=(out[15])~^(out[14]);
                end
            2'b010:
                begin
                out<=out<<1;
                out[0]<=~((out[15])&(out[14]));
                end
            2'b011:
                begin
                out<=out>>1;
                out[15]<=~((out[0])&(out[1]));
                end
            2'b100:
                
                out<={out[14:9],~out[15],out[8:0]};
  
            2'b101:
            
                out<={out[14:10],~out[15],out[9:0]};
            2'b110:
            
               out<={out[14:8],~out[15],out[7:0]};
               
            2'b111:
            
                out<={out[14:6],~out[15],out[5:0]};
                
            default:
            
                out<={out[14:5],~out[15],out[4:0]};
            
        endcase
endmodule


module prime_number_checker(clk,number1,prime);
input clk;
input[15:0] number1;
output reg[15:0] prime=0;

reg[15:0] counter=0;
reg[15:0] factor=0;
reg start_checking=1;
reg[15:0] num1;


begin

always @(posedge clk)
        if(start_checking)
            num1=number1;
        
 always @(posedge clk)
        begin
            start_checking=1'b0;
            counter=counter+1;
            if(num1%counter==1'b0)
                factor=factor+1;   
        end
            
 always @(posedge clk)
            if (counter==num1 & factor==16'd2)
                    begin
                    prime=num1;
                    factor=1'b0;
                    counter=1'b0;
                    start_checking=1'b1;  
                    end  
            else
               if(counter==num1 & factor>16'd2)
                       begin
                       start_checking=1'b1;
                       factor=1'b0;
                       counter=1'b0;
                       end       
                
                
                      
end
                
  
endmodule




module prbs_8bit(clk,sel,start,out);
        input clk,start;
        input[1:0] sel;
        output reg[7:0] out=0;
        always @(posedge clk)
        if(start==1'b1)
        case (sel)
            2'b00:
                begin
                out<=out>>1;
                out[7]<=(out[1])~^(out[0]);
                end
            2'b01:
                begin
                out<=out<<1;
                out[0]<=(out[7])~^(out[6]);
            end
            2'b10:
            begin
                out<=out<<1;
                out[0]<=~((out[7])&(out[6]));
                end
            2'b11:
            begin
                out<=out>>1;
                out[7]<=~((out[0])&(out[1]));
            end
        endcase
endmodule



module memory_based_prime_generator(clk,start,sel_8,sel_16,prime);
    input clk,start;
    input[1:0] sel_8;
    input[2:0] sel_16;
    output[15:0] prime;
    
    wire[15:0] prime_feed;
    wire [7:0] location;
    wire [15:0] random_number;
    reg[15:0] mem[255:0];
    integer i=0;
    
    
    prbs_16bit prbs_16(clk,sel_16,random_number);
    prime_number_checker pnc(clk,random_number,prime_feed);
    

    prbs_8bit prbs_init(clk,sel_8,start,location);
    assign prime=mem[location];
    
    
    always @(prime_feed)
            begin
            mem[i]=prime_feed;
            i=i+1;
            end
            
            
   always @(posedge clk)
        if(i==256)
            i=0;
   initial
    begin
            mem[60]=16'd2;
            mem[61]=16'd3;
            mem[62]=16'd5;
            mem[63]=16'd7;
            mem[64]=16'd11;
            mem[65]=16'd13;
            mem[66]=16'd17;
            mem[67]=16'd19;
            mem[68]=16'd23;
            mem[69]=16'd29;
            mem[10]=16'd31;
            mem[11]=16'd37;
            mem[12]=16'd41;
            mem[13]=16'd43;
            mem[14]=16'd47;
            mem[15]=16'd53;
            mem[16]=16'd59;
            mem[17]=16'd61;
            mem[18]=16'd67;
            mem[19]=16'd71;
            mem[20]=16'd73;
            mem[21]=16'd79;
            mem[22]=16'd83;
            mem[23]=16'd89;
            mem[24]=16'd97;
            mem[25]=16'd101;
            mem[26]=16'd103;
            mem[27]=16'd661;
            mem[28]=16'd673;
            mem[29]=16'd683;
            mem[30]=16'd677;
            mem[31]=16'd691;
            mem[32]=16'd701;
            mem[33]=16'd719;
            mem[34]=16'd929;
            mem[35]=16'd941;
            mem[36]=16'd947;
            mem[37]=16'd953;
            mem[38]=16'd967;
            mem[39]=16'd971;
            mem[40]=16'd977;
            mem[41]=16'd983;
            mem[42]=16'd991;
            mem[43]=16'd997;
            mem[44]=16'd10007;
            mem[45]=16'd10009;
            mem[46]=16'd10037;
            mem[47]=16'd10061;
            mem[48]=16'd10091;
            mem[49]=16'd10093;
            mem[50]=16'd10099;
            mem[51]=16'd10103;
            mem[52]=16'd10111;
            mem[53]=16'd10133;
            mem[54]=16'd10141;
            mem[55]=16'd10193;
            mem[56]=16'd10211;
            mem[57]=16'd10223;
            mem[58]=16'd10247;
            mem[59]=16'd11003;
            mem[0]=16'd11027;
            mem[1]=16'd11031;
            mem[2]=16'd11033;
            mem[3]=16'd11039;
            mem[4]=16'd11063;
            mem[5]=16'd11069;
            mem[6]=16'd11073;
            mem[7]=16'd11087;
            mem[8]=16'd11089;
            mem[9]=16'd11093;
            mem[70]=16'd11113;
            mem[71]=16'd12001;
            mem[72]=16'd12007;
            mem[73]=16'd12011;
            mem[74]=16'd12109;
            mem[75]=16'd12163;
            mem[76]=16'd12203;
            mem[77]=16'd12209;
            mem[78]=16'd12241;
            mem[79]=16'd12301;
            mem[80]=16'd12307;
            mem[81]=16'd12319;
            mem[82]=16'd12401;
            mem[83]=16'd12409;
            mem[84]=16'd12413;
            mem[85]=16'd12427;
            mem[86]=16'd20011;
            mem[87]=16'd20021;
            mem[88]=16'd20023;
            mem[89]=16'd20029;
            mem[90]=16'd20031;
            mem[91]=16'd20033;
            mem[92]=16'd20041;
            mem[93]=16'd20051;
            mem[94]=16'd20053;
            mem[95]=16'd20071;
            mem[96]=16'd20089;
            mem[97]=16'd20093;
            mem[98]=16'd20101;
            mem[99]=16'd20107;
            mem[100]=16'd20111;
            mem[101]=16'd20113;
            mem[102]=16'd20129;
            mem[103]=16'd20131;
            mem[104]=16'd20143;
            mem[105]=16'd20149;
            mem[106]=16'd20161;
            mem[107]=16'd22079;
            mem[108]=16'd22103;
            mem[109]=16'd22111;
            mem[110]=16'd22117;
            mem[111]=16'd22121;
            mem[112]=16'd22123;
            mem[113]=16'd22147;
            mem[114]=16'd22151;
            mem[115]=16'd22169;
            mem[116]=16'd22171;
            mem[117]=16'd30011;
            mem[118]=16'd30029;
            mem[119]=16'd30031;
            mem[120]=16'd30037;
            mem[121]=16'd30059;
            mem[122]=16'd30061;
            mem[123]=16'd30071;
            mem[124]=16'd30073;
            mem[125]=16'd30089;
            mem[126]=16'd30091;
            mem[127]=16'd30097;
            mem[128]=16'd30111;
            mem[129]=16'd30119;
            mem[130]=16'd30127;
            mem[131]=16'd30133;
            mem[132]=16'd30211;
            mem[133]=16'd30223;
            mem[134]=16'd30259;
            mem[135]=16'd30261;
            mem[136]=16'd30271;
            mem[137]=16'd30293;
            mem[138]=16'd30323;
            mem[139]=16'd30337;
            mem[140]=16'd30341;
            mem[141]=16'd30347;
            mem[142]=16'd30349;
            mem[143]=16'd30359;
            mem[144]=16'd30389;
            mem[145]=16'd30403;
            mem[146]=16'd30763;
            mem[147]=16'd30799;
            mem[148]=16'd30803;
            mem[149]=16'd30809;
            mem[150]=16'd31057;
            mem[151]=16'd31061;
            mem[152]=16'd31073;
            mem[153]=16'd31181;
            mem[154]=16'd31183;
            mem[155]=16'd31193;
            mem[156]=16'd31219;
            mem[157]=16'd31223;
            mem[157]=16'd31231;
            mem[158]=16'd31651;
            mem[159]=16'd31669;
            mem[160]=16'd31691;
            mem[161]=16'd31703;
            mem[162]=16'd40001;
            mem[163]=16'd40009;
            mem[164]=16'd40011;
            mem[165]=16'd40021;
            mem[166]=16'd40023;
            mem[167]=16'd40039;
            mem[168]=16'd40099;
            mem[169]=16'd40111;
            mem[170]=16'd40117;
            mem[171]=16'd40127;
            mem[172]=16'd40129;
            mem[173]=16'd40141;
            mem[174]=16'd40143;
            mem[175]=16'd40151;
            mem[176]=16'd40157;
            mem[178]=16'd40547;
            mem[179]=16'd40553;
            mem[180]=16'd40561;
            mem[181]=16'd40999;
            mem[182]=16'd41041;
            mem[183]=16'd45059;
            mem[184]=16'd45061;
            mem[185]=16'd45067;
            mem[186]=16'd45073;
            mem[187]=16'd45113;
            mem[188]=16'd45137;
            mem[189]=16'd45119;
            mem[190]=16'd45113;
            mem[191]=16'd45149;
            mem[192]=16'd47227;
            mem[193]=16'd47239;
            mem[194]=16'd47251;
            mem[195]=16'd47253;
            mem[196]=16'd47239;
            mem[197]=16'd47257;
            mem[198]=16'd47261;
            mem[199]=16'd47519;
            mem[200]=16'd47521;
            mem[201]=16'd47729;
            mem[202]=16'd47731;
            mem[203]=16'd49471;
            mem[204]=16'd49549;
            mem[205]=16'd49571;
            mem[206]=16'd49573;
            mem[207]=16'd49727;
            mem[208]=16'd49739;
            mem[209]=16'd49979;
            mem[210]=16'd49981;
            mem[211]=16'd55073;
            mem[212]=16'd55217;
            mem[213]=16'd55231;
            mem[214]=16'd55297;
            mem[215]=16'd55319;
            mem[216]=16'd55453;
            mem[217]=16'd57731;
            mem[218]=16'd58243;
            mem[219]=16'd58301;
            mem[220]=16'd58373;
            mem[221]=16'd59371;
            mem[222]=16'd59539;
            mem[223]=16'd59603;
            mem[224]=16'd59737;
            mem[225]=16'd59773;
            mem[226]=16'd59779;
            mem[227]=16'd59821;
            mem[228]=16'd59827;
            mem[229]=16'd59993;
            mem[230]=16'd60011;
            mem[231]=16'd60043;
            mem[232]=16'd60109;
            mem[233]=16'd60119;
            mem[234]=16'd60127;
            mem[235]=16'd61117;
            mem[236]=16'd61181;
            mem[237]=16'd61183;
            mem[238]=16'd61333;
            mem[239]=16'd61337;
            mem[240]=16'd61353;
            mem[241]=16'd62209;
            mem[242]=16'd62221;
            mem[243]=16'd62603;
            mem[244]=16'd63889;
            mem[245]=16'd63893;
            mem[246]=16'd63901;
            mem[247]=16'd63917;
            mem[248]=16'd63943;
            mem[249]=16'd63949;
            mem[250]=16'd63959;
            mem[251]=16'd63937;
            mem[252]=16'd63961;
            mem[253]=16'd63937;
            mem[254]=16'd63979;
            mem[255]=16'd63997;
    end
                        
endmodule

///////////////////////////////////////////////////////////////////////////////////
///////multiplier block
////last Adder block (tested)
module last_fa(sum_in,carry_in,x,y,out);
    parameter size=17; //size of multiplier and multiplicant
    input[size-3:0] sum_in;//sum_in value of last horizontal block
    input[size-2:0] carry_in;   //carry_in of last carry_in block
    input x,y;//msb bit of multiplier and multiplicant
    output[size-1:0] out; //product output of last horizontal block
    
    wire[size-2:0] carry_internal; //internal carry connections
    
    genvar i;
    
    
    fa fa_l(sum_in[0],1'b1,carry_in[0],out[0],carry_internal[0]);
    //replicate full adder of last block
    generate for(i=1;i<size-2;i=i+1)
        begin:last_fa
        fa fa_lg(sum_in[i],carry_internal[i-1],carry_in[i],out[i],carry_internal[i]);
        end
    endgenerate
    //last 2 full adder of last block
    fa fa_2_last((x&y),carry_internal[size-3],carry_in[size-2],out[size-2],carry_internal[size-2]);
    assign out[size-1]=1'b1+carry_internal[size-2]+1'b0;
                     
endmodule   
    
    





//full adder
module fa(innA,innB,carry_in,sum,carry_out);
    input innA,innB,carry_in;
    output sum,carry_out;
    
    assign {carry_out,sum}=innA+innB+carry_in;
endmodule
 
//replicated horizontal block consist of n-1 adder
module adder_block(vertical_inn,horizontal_inn,carry_in,sum,carry_out);
    parameter size=17;//size of multiplier and multiplicant
    input[size-2:0] vertical_inn;//input from upper blocks
    input[size-2:0] horizontal_inn;//input from left blocks
    input [size-2:0] carry_in;//carry input
    output[size-2:0] sum; //sum output for lower blocks
    output[size-2:0] carry_out;//carry output for lower blocks
    
    genvar i;
    
    //replicate the full adder block horizontally
    generate for(i=0;i<size-1;i=i+1)
        begin:full_adder
            fa full_add(vertical_inn[i],horizontal_inn[i],carry_in[i],sum[i],carry_out[i]);    
        end
   endgenerate
endmodule       
    




//did nand operation for 2nd last block
module nand_block(arr,inn,out);
    parameter size=17; //size of multiplier and multiplicant
    input[size-2:0] arr;//vector input for nand
    input inn;//bit input for nand
    output[size-2:0] out;//output after nand operation
    genvar i;
    
    //replication of nand gate
    generate for(i=0;i<size-1;i=i+1)
    begin:bit
        assign out[i]=~(arr[i]&inn);
    end
    endgenerate       
endmodule

//did and operation for 2nd last block
module and_block(arr,inn,out);
    parameter size=17;//size of multiplier and multiplicant
    input[size-2:0] arr; //vectored input
    input inn;//bit input
    output [size-2:0] out;
    genvar i;
    //replicate and operation
    generate for(i=0;i<size-1;i=i+1)
    begin:bit
        assign out[i]=arr[i]&inn;
    end
    endgenerate       
endmodule


//woogh_boogly block    
module woogh_boogly(input1,input2,product);
    parameter size=17; //size of multiplier and multiplicant
    input[size-1:0] input1,input2;//multiplier and multiplicant
    output[(2*size)-1:0] product; //product of multiplication
    
    wire[size-1:0] first_vertical_inn;
    wire[size-2:0] first_horizontal_inn;
    wire[size-2:0] nand_horizontal_inn;
    wire[size-2:0] first_carry_in;
    wire [size-2:0] sum [size-2:0]; 
    wire[size-2:0] carry [size-2:0];
    wire[size-2:0] gen_horizontal_inn[size-3:1];
    
    genvar i;

    //first row
    and_block and_v_1(input1[size-2:0],input2[0],first_vertical_inn[size-2:0]); //nand operation for vertical block
    assign first_vertical_inn[size-1]=~(input1[size-1]&input2[0]);//msb nand operation
    
    and_block and_h_1(input1[size-2:0],input2[1],first_horizontal_inn);//left operation for left block
    
    adder_block add1(first_vertical_inn[size-1:1],first_horizontal_inn,0,sum[0],carry[0]); //1st block
    assign product[0]=first_vertical_inn[0]; //lsb of product
    assign product[1]=sum[0][0];//product[1]
    
    
    
    //generate block for FA_block from second to excluding last two block
    
    generate for(i=1;i<size-2;i=i+1)
        begin:fa_block
            and_block and_h(input1[size-2:0],input2[i+1],gen_horizontal_inn[i]); //and block for that block
            adder_block add1({~(input1[size-1]&input2[i]),sum[i-1][size-2:1]},gen_horizontal_inn[i],carry[i-1],sum[i],carry[i]); //horizontal adder group
            assign product[i+1]=sum[i][0]; //product[i]
       end
   endgenerate
   //second last FA_nand_block
            nand_block nand1(input1[size-2:0],input2[size-1],nand_horizontal_inn);//nand operation for block
            adder_block add_nand({~(input1[size-1]&input2[size-2]),sum[size-3][size-2:1]},nand_horizontal_inn,carry[size-3],sum[size-2],carry[size-2]);//horizontal adder block
            assign product[size-1]=sum[size-2][0]; //second last bit of product
               
    // last adder block operation and rest bit of product value assignment
    last_fa last(sum[size-2][size-2:1],carry[size-2],input1[size-1],input2[size-1],product[(2*size)-1:size]);
    
endmodule

////////////////////////////////////////////////////
///////Private key generator with concept of parallelism

module private_key_generator(clk,public_key,phi,private_key);
    input clk;
    input[15:0] public_key;
    input[31:0] phi;
    output reg [15:0] private_key=1'b0;
    reg[31:0] lhs,mul;
    reg[15:0] rhs=1;
    
    reg[15:0] count_1=16'd0,count_2=16'd10000,count_3=16'd20000,count_4=16'd30000,count_5=16'd40000,count_6=16'd50000,count_7=16'd60000;
     
    
    always @(posedge clk)
        if(private_key==0)
            begin
            count_1=count_1+1;
            mul=(count_1*public_key);
            lhs=mul%phi;
            
            if (lhs==rhs)
                private_key=count_1;
            if((count_1==16'hffff) |(private_key==0))
                        rhs=rhs+1;
           end     
           
           
//    always @(*)
//        if((count_2!=16'd20000) & (private_key==1'b0))
            
//    always @(*)
//        if((count_3!=16'd30000) & (private_key==1'b0))
//            begin
//            lhs=(count_3*public_key)%phi;
//            if (lhs==1'b1)
//                private_key=count_3;
//            else
//                count_3=count_3+1'b1;
//           end     
//    always @(*)
//        if((count_4!=16'd40000) & (private_key==1'b0))
//            begin
//            lhs=(count_4*public_key)%phi;
//            if (lhs==1'b1)
//                private_key=count_4;
//            else
//                count_4=count_4+1'b1;
//           end    
//    always @(*)
//        if((count_5!=16'd50000) & (private_key==1'b0))
//            begin
//            lhs=(count_5*public_key)%phi;
//            if (lhs==1'b1)
//                private_key=count_5;
//            else
//                count_5=count_5+1'b1;
//           end  
//    always @(*)
//        if((count_6!=16'd60000) & (private_key==1'b0))
//            begin
//            lhs=(count_6*public_key)%phi;
//            if (lhs==1'b1)
//                private_key=count_6;
//            else
//                count_6=count_6+1'b1;
//           end 
//    always @(*)
//        if((count_7!=16'hFFFF) & (private_key==1'b0))
//            begin
//            lhs=(count_7*public_key)%phi;
//            if (lhs==1'b1)
//                private_key=count_7;
//            else
//                count_7=count_7+1'b1;
//           end  
endmodule


module rsa_key_gen(clk,start,sel_8,sel_16,private_key,wire_final_public_key,wire_final_n,prime1);
    input clk,start;
    input[1:0] sel_8;
    input[2:0] sel_16;
    output [15:0] wire_final_public_key;
    output [15:0] private_key;
    output[15:0] prime1;
    output[31:0] wire_final_n;
    
    reg flag=0;
    
    wire[15:0]prime2;
    wire[16:0] prime1_padded,prime2_padded,sub1_padded,sub2_padded;
    wire[15:0] sub1,sub2;
    wire[31:0] phi,n;
    wire[15:0] public_key;
    reg[31:0] final_phi,final_n;
    reg[15:0] final_public_key;
    wire[31:0] wire_final_phi;
    reg flag_delay=1;
    reg[3:0] count=0;
                
       assign wire_final_phi=final_phi;
       assign wire_final_n=final_n;
       assign wire_final_public_key=final_public_key;
       
       assign prime1_padded={0,prime1};
       assign prime2_padded={0,prime2};
           
    //substractor block
    
    assign sub1=prime1-1;
    assign sub2=prime2-1;
    
    //substractor padded
    assign sub1_padded={0,sub1};
    assign sub2_padded={0,sub2};
    
  
    //Prime generator
    memory_based_prime_generator mbpg1(clk,start,sel_8+1,sel_16,prime1);
    memory_based_prime_generator mbpg2(clk,start,sel_8,sel_16+2,prime2);
      
    //multiplier block
    woogh_boogly wb1(prime1_padded,prime2_padded,n);
    woogh_boogly wb2(sub1_padded,sub2_padded,phi);
    
    //public key generator
    memory_based_prime_generator mbpg3(clk,start,sel_8+3,sel_16+2'd2,public_key);
    
    always @(posedge clk)
        begin
        count<=count+1'b1;
        if(count==4'd10)
                flag_delay=0;
        end
        
    
    always @(posedge clk)
        if(flag==0 & flag_delay==0)
            begin
                final_phi=phi;
                final_n=n;
                final_public_key=public_key;
                flag=1;
            end

           
    
    
    
    //private key generator
    private_key_generator pkg(clk,wire_final_public_key,wire_final_phi,private_key);
    
        
endmodule

module seg7decimal(clk,x,seg,an,dp);
        input clk;
        output reg [6:0] seg;
        output reg [7:0] an;
        output wire dp;
        wire [3:0] s;
        input [31:0] x;
        reg [3:0] digit;
        wire [7:0] aen;
        reg [19:0] clkdiv;
        assign dp = 1;
        assign s = clkdiv[19:17];
        assign aen = 8'b11111111;
        always @(posedge clk)
        case(s)
            0:digit = x[3:0];
            1:digit = x[7:4];
            2:digit = x[11:8];
            3:digit = x[15:12];
            4:digit = x[19:16];
            5:digit = x[23:20];
            6:digit = x[27:24];
            7:digit = x[31:28];
            default:digit = x[3:0];
        endcase
        
        always @(*)
        case(digit)
            0:seg = 7'b1000000;
            1:seg = 7'b1111001;
            2:seg = 7'b0100100;
            3:seg = 7'b0110000;
            4:seg = 7'b0011001;
            5:seg = 7'b0010010;
            6:seg = 7'b0000010;
            7:seg = 7'b1111000;
            8:seg = 7'b0000000;
            9:seg = 7'b0010000;
            'hA:seg = 7'b0001000;
            'hB:seg = 7'b0000011;
            'hC:seg = 7'b1000110;
            'hD:seg = 7'b0100001;
            'hE:seg = 7'b0000110;
            'hF:seg = 7'b0001110;
            default: seg = 7'b0000000;
        endcase
        always @(*)
        begin
            an=8'b11111111;
            if(aen[s] == 1)
            an[s] = 0;
        end
        always @(posedge clk) begin
            clkdiv <= clkdiv+1;
        end
endmodule

module key_cache(clk,key,private_key,wire_final_public_key,n, out_private_key,out_wire_final_public_key,out_n);
    input clk;
    input[2:0] key;
    input[15:0] private_key,wire_final_public_key;
    input[31:0] n;
    
    output[15:0] out_private_key,out_wire_final_public_key;
    output[31:0] out_n;
    
    reg[15:0] public_key_cache[2:0];
    reg[15:0] private_key_cache[2:0];
    reg[31:0] n_key_cache[2:0];
    
    assign out_private_key=private_key_cache[key];
    assign out_wire_final_public_key=public_key_cache[key];
    assign out_n=n_key_cache[key];
    
    initial
        begin
            public_key_cache[0]=16'd31;
            private_key_cache[0]=16'd43301;
            n_key_cache[0]=32'd2249143156;
            
            public_key_cache[1]=16'd47;
            private_key_cache[1]=16'd34481;
            n_key_cache[1]=32'd2312257920;
    
            public_key_cache[2]=16'd41;
            private_key_cache[2]=16'd50663;
            n_key_cache[2]=32'd2343641136;
            
            public_key_cache[3]=16'd23;
            private_key_cache[3]=16'd39367;
            n_key_cache[3]=32'd2257668379;
            
            public_key_cache[4]=16'd37;
            private_key_cache[4]=16'd51901;
            n_key_cache[4]=32'd2399203027;
            
            public_key_cache[5]=16'd29;
            private_key_cache[5]=16'd29785;
            n_key_cache[5]=32'd2159638763;
            
            public_key_cache[6]=16'd19;
            private_key_cache[6]=16'd44347;
            n_key_cache[6]=32'd2101962941;
            
            public_key_cache[6]=16'd19;
            private_key_cache[6]=16'd44347;
            n_key_cache[6]=32'd2101962941;
            
            public_key_cache[7]=wire_final_public_key;
            private_key_cache[7]=private_key;
            n_key_cache[7]=n;
          
       end  
       
    
 endmodule
    

module seven_seg_random_prime_generator(clk,start,sel_8,sel_16,seg,an,dp);
        input clk;
        input start;
        
        input[1:0] sel_8;
        input[2:0] sel_16;
        
        output[7:0] an;
        output[6:0] seg;
        output dp;
        wire[15:0] private_key,public_key,prime1;
        wire[31:0] n;
        
        wire[15:0] out_private_key,out_wire_final_public_key;
        wire[31:0] out_n;
        wire flag;
        wire[31:0] led_input;
        
        
        
        rsa_key_gen rsa(clk,start,sel_8,sel_16,private_key,public_key,prime1,n);
        key_cache kc(clk,prime1,private_key,public_key,n,out_private_key,out_wire_final_public_key,out_n);
        assign led_input=out_private_key+out_wire_final_public_key;
        seg7decimal display(clk,{private_key,public_key},seg,an,dp);
        
endmodule
