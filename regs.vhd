library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity regs is
  Port(clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       addr1 : in  STD_LOGIC_VECTOR (4 downto 0);
		 addr2 : in  STD_LOGIC_VECTOR (4 downto 0);
		 waddr : in  STD_LOGIC_VECTOR (4 downto 0);
       data_in : in STD_LOGIC_VECTOR (31 downto 0);
       write_enable : in  STD_LOGIC;
       data_out1 : out  STD_LOGIC_VECTOR (31 downto 0);
		 data_out2 : out  STD_LOGIC_VECTOR (31 downto 0));
end regs;

architecture Behavioral of regs is
  type t_mem is array (0 to 31) of std_logic_vector(31 downto 0);
  signal array_mem : t_mem;
begin
process(clk,reset,write_enable,addr1,addr2,array_mem)
  begin
    if(reset='1') then
      -- NOTE: the following functionality allows you to initialize
      -- the contents of the memory
      array_mem <= (
        "00000000000000000000000000000000", -- 32-bit word at addr 0
        "00000000000000000000000000000000", -- 32-bit word at addr 1
        "00000000000000000000000000000000", -- 32-bit word at addr 2
        -- you can add more 32-bit words here if needed...
        -- the following line sets all other bytes in the memory to 0
        others => "00000000000000000000000000000000" );
    elsif(clk'event and clk='1' and write_enable='1') then
      array_mem(to_integer(unsigned(waddr))) <= data_in;
    end if;
     
    if(reset='0') then
      data_out1 <= array_mem(to_integer(unsigned(addr1)));
		data_out2 <= array_mem(to_integer(unsigned(addr2)));
    else
      data_out1 <= "00000000000000000000000000000000";
		data_out2 <= "00000000000000000000000000000000";
    end if;
  end process;
end Behavioral;
