library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity rom_memory is
	port(
		clk 		 	: in std_logic;
		address		 	: in std_logic_vector(7 downto 0);
		
		rom_data_output : out std_logic_vector(7 downto 0)
	);
end rom_memory;

architecture arch of rom_memory is 



--op codes

constant load_A_imm					:std_logic_vector(7 downto 0) := x"86";
constant load_a						:std_logic_vector(7 downto 0) := x"87";
constant load_b_imm					:std_logic_vector(7 downto 0) := x"88";
constant load_B						:std_logic_vector(7 downto 0) := x"89";
constant store_reg_A				:std_logic_vector(7 downto 0) := x"96";	
constant store_reg_B				:std_logic_vector(7 downto 0) := x"97";



constant add_AB						:std_logic_vector(7 downto 0) := x"42";
constant sub_AB						:std_logic_vector(7 downto 0) := x"43";
constant AND_AB						:std_logic_vector(7 downto 0) := x"44";
constant OR_AB						:std_logic_vector(7 downto 0) := x"45";
constant inc_A						:std_logic_vector(7 downto 0) := x"46";
constant inc_B						:std_logic_vector(7 downto 0) := x"47";
constant dec_A						:std_logic_vector(7 downto 0) := x"48";
constant dec_B						:std_logic_vector(7 downto 0) := x"49";

constant skip						:std_logic_vector(7 downto 0) := x"20";
constant skip_negative				:std_logic_vector(7 downto 0) := x"21";
constant skip_positive				:std_logic_vector(7 downto 0) := x"22";
constant skip_equal_zero			:std_logic_vector(7 downto 0) := x"23";
constant skip_not_equal_zero		:std_logic_vector(7 downto 0) := x"24";
constant skip_OVERFLOW				:std_logic_vector(7 downto 0) := x"25";
constant skip_no_OVERFLOW			:std_logic_vector(7 downto 0) := x"26";
constant skip_carry_in				:std_logic_vector(7 downto 0) := x"27";
constant skip_no_carry_in			:std_logic_vector(7 downto 0) := x"28";

type rom_type is array (127 to 0) of std_logic_vector(7 to 0);

constant rom : rom_type := (
							0	=> load_a,	
                            1	=> x"F0",	-- input port-00
                            2	=> load_B,
                            3	=> x"F1",	-- input port-01	
                            4 	=> add_AB,
                            5   => skip_equal_zero,
							6   => x"0B",		
							7   => load_a,
							8   => X"80",	
							9	=> skip,
							10	=> x"20",
							11	=> load_a,
							12	=> x"F2",	-- input port-02	
							13  => skip,
							14  => x"04",						
							others 	=> x"00"	
							
							);

signal enable : std_logic;




begin
process(address)
begin
	if(address >= x"00" and address <= x"7f") then 
		enable <= '1';
	
	else 
		enable  <= '0';
	end if ;
end process;


process(clk)
begin
	if(rising_edge(clk)) then 
		if (enable = '1') then
		rom_data_output <= rom(to_integer(unsigned(address))) ; 
			
		  end if ;
	end if;

			
			
end process;




end architecture;