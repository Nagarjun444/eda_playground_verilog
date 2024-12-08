// Code your testbench here
// or browse Examples
class ABC;
  rand bit[7:0] var1;
  rand bit[7:0] var2;
  rand bit[7:0] var3;
  rand bit[7:0] var4;
  
  function void rand_all();
    
    $display ("var1 = %d",var1);              
     $display ("var2 = %d",var2);                     
     $display ("var3 = %d",var3);
     $display ("var4 = %d",var4); 
    
  endfunction
  
  function ran1();
    
    var1.rand_mode(1);
      
    var2.rand_mode(0);
      
    var3.rand_mode(1);
       
    var4.rand_mode(1); 
    
    
    
    $display ("var1 = %d",var1);              
     $display ("var2 = %d",var2);                     
     $display ("var3 = %d",var3);
     $display ("var4 = %d",var4); 
    
  endfunction
                             
endclass

module tb;

  initial 
    begin
    ABC abc = new();
      $display("rand all");
     //abc.randomize(); 
    //abc.rand_all(); 
      
      $display("rand only var 2");
      
      
      
      
      
      abc.var1.rand_mode(0);
      
      abc.var2.rand_mode(1);
       
      abc.var3.rand_mode(0);
      
      abc.var4.rand_mode(0);
      abc.randomize(); 
      abc.rand_all(); 
      $display("rand only var 3");
      abc.var1.rand_mode(1);
      
      abc.var2.rand_mode(1);
       
      abc.var3.rand_mode(0);
      
      abc.var4.rand_mode(0);
      abc.randomize(); 
      abc.rand_all();
      
       
       

  end
endmodule




class packet;
  rand byte addr;
  rand byte data;   
endclass

module rand_methods;
  initial begin
    packet pkt;
    pkt = new();
    
    //disable rand_mode of addr variable of pkt
    pkt.addr.rand_mode(0);
    
    //calling randomize method
    pkt.randomize();
    
    $display("\taddr = %0d \t data = %0d",pkt.addr,pkt.data);
    
    $display("\taddr.rand_mode() = %0d \t data.rand_mode() = %0d",pkt.addr.rand_mode(),pkt.data.rand_mode());
  end
endmodule




typedef enum {IDLE, RUN, P0, P1} cmd_t;

///// Base Class Declaration
class Packet;
 
 /// Properties
 cmd_t cmd;
 int status;
 bit [7:0] data [0:255];
 
 /// Method
 virtual function void SetStatus (input int y);
 status = y;
 endfunction: SetStatus
 
endclass: Packet

///// Extended Class Declaration
class myPacket extends Packet;
 
 /// Added Properties
 bit errBit;
 
 /// Newly Added Method
 function bit ShowError();
   return(errBit);
 endfunction: ShowError
 
 /// Overriding Method
 virtual function void SetStatus (input int y);
   status = y + 2;
 endfunction: SetStatus
 
endclass: myPacket

module top;

 Packet pkt = new;
 myPacket m_pkt = new;
 
 task my_run (Packet PKT);

   PKT.SetStatus(2);
   $display("Status value is = %0d", PKT.status); 
   endtask: my_run
 
 initial begin
   my_run(pkt);
   my_run(m_pkt);
 end
 
endmodule: top



class parent;
  bit [31:0] addr;
  
  function display();
     addr = 10;
    $display("class_parent=%0d",addr);
  endfunction
  
endclass


class child extends parent;
  bit [31:0] data;
   
  function display();
    data=20;
    super.display();
    $display("class_child=%0d",data);
  endfunction
  
endclass

module nag;
  initial 
    begin
      parent per;
      child call=new();
      child  big;
           
     per = call;
      $cast( big,per);
      big.display();

      
      
    end
endmodule




//----------------------------------------------------------------------//
//              example2 : Enumeration Type [DataTypes]			        //
//	This example shows how to declare enum, how to use the enumeration	//
//					methods first and name 						// 
//----------------------------------------------------------------------//

module enum_datatype;

  //declaration
  enum { red, green, yellow, white, black } Colors;
  
  //display members of Colors
  initial begin
    Colors = Colors.first;
    for(int i=0;i<6;i++) begin
      $display("Colors :: Value of  %0s \t is = %0d",Colors.name,Colors);
      Colors = Colors.next;      
    end
  end
  
endmodule


class parent_class;
  local bit [31:0] tmp_addr;
  bit [31:0] smp;
   
  function new(bit [31:0] r_addr);
    smp = r_addr + 10;
     tmp_addr =20;
  endfunction

  function display();
    $display("tmp_addr = %0d",tmp_addr);
    $display("tmp_addr = %0d",smp);
    
  endfunction
endclass

//-------------------------------------------------------------------------
//   module
//-------------------------------------------------------------------------
module encapsulation;
  initial begin
    parent_class p_c = new(5);
       
    p_c.tmp_addr = 20;  //Accesing local variable outside the class
    p_c.display();
  end
endmodule



//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
//abstract class
 class packet;
  bit [31:0] addr;
//    int c;
   function new(bit[31:0] a, int b,int c);
     
    addr = a+b+c;
     $display("addr= %0d",addr);
   endfunction   
   
endclass

 
module virtual_class;
  initial
    begin
      packet pac = new(2,3,10);
//     pac.display();
  end
endmodule










