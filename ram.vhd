library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ram_memory is
	port(
		clk 		 	: in std_logic;
		address		 	: in std_logic_vector(7 downto 0);
		ram_data_in		: in std_logic_vector(7 downto 0);
		
		write_en		: in std_logic;					
		
		
		ram_data_output : out std_logic_vector(7 downto 0)
	);
end ram_memory;

architecture arch of ram_memory is 

type ram_type is array (128 to 223) of std_logic_vector(7 to 0);

signal ram : ram_type := (others => x"00");


signal enable : std_logic;

begin


process(address)
begin
	if(address >= x"80" and address <= x"Df") then 
		enable <= '1';
	
	else 
		enable  <= '0';
	end if ;
end process;



process(clk)
begin
	if(rising_edge(clk)) then 
		if (enable = '1' and write_en = '1') then
		ram(to_integer(unsigned(address))) <= ram_data_in ;
		
		elsif (enable ='1' and write_en = '0') then 
		
		ram_data_output <= ram(to_integer(unsigned(address)));
		
			
		  end if ;
	end if;

			
			
end process;


							
end architecture;