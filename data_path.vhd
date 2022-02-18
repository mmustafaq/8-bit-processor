library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity data_path is
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
		bus_1_sel	:		in std_logic_vector(1 downto 0);
		bus_2_sel	: 		in std_logic_vector(1 downto 0);
		from_memory	: 		in std_logic_vector(7 downto 0);
		
		ir			:		out std_logic_vector(7 downto 0);
		address		:		out std_logic_vector(7 downto 0);
		ccr_result	:		out std_logic_vector(3 downto 0);
		to_memory	:		out std_logic_vector(7 downto 0)
		
		);
		
end data_path;

architecture arch of data_path is


component ALU is
	port(
			A			: in std_logic_vector(7 downto 0);
			B			: in std_logic_vector(7 downto 0);
			ALU_Sel		: in std_logic_vector(2 downto 0);
			
			NZVC		: out std_logic_vector(3 downto 0);
			ALU_result	: out std_logic_vector(7 downto 0)
	);
end component;


signal BUS1	 		 : std_logic_vector(7 downto 0);
signal BUS2			 : std_logic_vector(7 downto 0);
signal ALU_result	 : std_logic_vector(7 downto 0);
signal IR_reg		 : std_logic_vector(7 downto 0);
signal MAR 			 : std_logic_vector(7 downto 0);
signal PC 			 : std_logic_vector(7 downto 0);
signal A_reg		 : std_logic_vector(7 downto 0);
signal B_reg		 : std_logic_vector(7 downto 0);
signal CCR_in		 : std_logic_vector(3 downto 0);
signal CCR           : std_logic_vector(3 downto 0);

begin

    bus1 <= pc    when bus_1_sel <= "00" else
		    A_reg when bus_1_sel <= "01" else
		    B_reg when bus_1_sel <= "10" else (others => '0' );
		 
	bus2 <= ALU_result 	when bus_2_sel <= "00" else
			bus1 		when bus_2_sel <= "01" else
			from_memory	when bus_2_sel <= "10" else (others => '0');



--IR
process(clk,rst)
begin
	if(rst = '1') then 
		IR_reg <= (others => '0');
	elsif(rising_edge(clk)) then 
		if(ir_load='1') then 
			IR_reg <= bus2;
		end if;
	end if;
end process;

--MAR
process(clk,rst)
begin
	if(rst = '1') then 
		MAR <= (others => '0');
	elsif(rising_edge(clk)) then
		if(mar_load='1') then 
			MAR <= BUS2;
		end if;
	end if;
end process;
address <= MAR;

--PC
process(clk,rst)
begin
	if(rst = '1') then 
		PC <= (others => '0');
	elsif(rising_edge(clk)) then
		if(pc_load = '0') then 
			pc <= bus2;
		elsif(pc_inc = '1') then 
			pc <= pc + x"01";
		end if ;
	end if;
end process;


--A register

process(clk,rst)
begin
	if(rst ='1') then 
		A_reg <= (others => '0');
	elsif(rising_edge(clk)) then
		if(a_load = '1') then 
			A_reg <= bus2;
		end if;
	end if;
end process;


--B register

process(clk,rst)
begin
	if(rst ='1') then 
		B_reg <= (others => '0');
	elsif(rising_edge(clk)) then
		if(b_load = '1') then 
			B_reg <= bus2;
		end if;
	end if;
end process;

ALU_unit :  ALU port map (
							A 			=> B_reg,
							B 			=> bus1,
							ALU_Sel 	=> alu_sel,
							NZVC		=> ccr_in,
							ALU_result	=> ALU_result
						);
-- ccr register
process(clk,rst)
begin
if(rst='1') then 
	CCR <= (others => '0');
elsif(rising_edge(clk)) then
	if(ccr_load='1') then 
		ccr <= ccr_in;
	end if;
end if; 
end process;

ccr_result <= ccr;

to_memory <= BUS1;




end architecture;

