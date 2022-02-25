library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity cpu is
	port(
		clk				: in std_logic;	
		rst 			: in std_logic;
		from_memory		: in std_logic_vector(7 downto 0);
		
		
		to_memory		: out std_logic_vector(7 downto 0);
		write_en		: out std_logic;
		address			: out std_logic_vector(7 downto 0)	
	);
	
end cpu;



architecture arch of cpu is 
component control_unit is
	port(
			clk			: in std_logic;
			rst			: in std_logic;
			CCR_Result	: in std_logic_vector(3 downto 0);
			IR			: in std_logic_vector(7 downto 0);
			
			IR_Load		: out std_logic;	
			MAR_Load 	: out std_logic;
			PC_Load 	: out std_logic;
			PC_Inc 		: out std_logic;
			A_Load 		: out std_logic;
			B_Load 		: out std_logic;
			ALU_Sel 	: out std_logic_vector(2 downto 0);
			CCR_Load 	: out std_logic;
			BUS1_Sel	: out std_logic_vector(1 downto 0);
			BUS2_Sel	: out std_logic_vector(1 downto 0);
			write_en	: out std_logic

	);
end component;

component data_path is
	port(
	
		clk 		:	 	in std_logic;
		rst 		: 		in std_logic;
		ir_load		: 		in std_logic;
		mar_load	: 		in std_logic;
		pc_load 	: 		in std_logic;
		pc_inc 		: 		in std_logic;
		a_load 		: 		in std_logic;
		b_load 		: 		in std_logic;
		alu_sel		: 		in std_logic_vector(2 downto 0);
		ccr_load	: 		in std_logic;
		bus1_sel	:		in std_logic_vector(1 downto 0);
		bus2_sel	: 		in std_logic_vector(1 downto 0);
		from_memory	: 		in std_logic_vector(7 downto 0);
		
		ir			:		out std_logic_vector(7 downto 0);
		address		:		out std_logic_vector(7 downto 0);
		ccr_result	:		out std_logic_vector(3 downto 0);
		to_memory	:		out std_logic_vector(7 downto 0)
		
		);
		
end component;

signal IR_Load		: std_logic;	
signal IR			: std_logic_vector(7 downto 0);
signal MAR_Load 	: std_logic;
signal PC_Load 		: std_logic;
signal PC_Inc 		: std_logic;
signal A_Load 		: std_logic;
signal B_Load 		: std_logic;
signal ALU_Sel 		: std_logic_vector(2 downto 0);
signal CCR_Load 	: std_logic;
signal CCR_Result	: std_logic_vector(3 downto 0);	
signal BUS1_Sel		: std_logic_vector(1 downto 0);
signal BUS2_Sel		: std_logic_vector(1 downto 0);

begin

control_unit_module : control_unit port map(
												clk						=>		clk,	
												rst						=>		rst,
												CCR_Result	            =>		ccr_result,
												IR			            =>		IR,
												IR_Load		            =>		IR_Load,
												MAR_Load 	            =>		MAR_Load,	
												PC_Load 	            =>      PC_Load,		
												PC_Inc 		            =>      PC_Inc ,	
												A_Load 		            =>      A_Load ,	
												B_Load 		            =>      B_Load ,	
												ALU_Sel 	            =>      ALU_Sel ,	
												CCR_Load 	            =>      CCR_Load ,	
                                                BUS1_Sel	            =>   	BUS1_Sel,
                                                BUS2_Sel	            =>   	BUS2_Sel,	
                                                write_en	            =>      write_en		
											);
 data_path_module	: data_path port map(
 
											clk 					=>		  clk, 		
                                            rst 		            =>        rst ,		
                                            ir_load		            =>        ir_load,		
                                            mar_load	            =>        mar_load,	
                                            pc_load 	            =>        pc_load, 	
                                            pc_inc 		            =>        pc_inc, 		
                                            a_load 		            =>        a_load ,		
                                            b_load 		            =>        b_load ,		
                                            alu_sel		            =>        alu_sel,		
                                            ccr_load	            =>        ccr_load	,
                                            bus1_sel	            =>        bus1_sel	,
                                            bus2_sel	            =>        bus2_sel	,
                                            from_memory	            =>        from_memory,	
                                                                            
                                            ir			            =>        ir,			
                                            address		            =>        address,		
                                            ccr_result	            =>        ccr_result,	
                                            to_memory	            =>        to_memory	
                                                                    
                                                                    
                                                                    
										);                          
                                                                    
                                                                    
                                                                    
                                                                    
                                                                    
end architecture;                                                   
                                                                    
                                                                    