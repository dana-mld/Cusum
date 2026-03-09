----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2025 16:28:24
-- Design Name: 
-- Module Name: ram - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Added for arithmetic operations

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram is
    Port ( addr : in STD_LOGIC_VECTOR (10 downto 0);
           dout_curr : out STD_LOGIC_VECTOR (31 downto 0);
           dout_prev : out STD_LOGIC_VECTOR (31 downto 0));
end ram;

architecture Behavioral of ram is
    type rom_type is array (0 to 2047) of std_logic_vector(31 downto 0);
   
    signal rom_matrix : rom_type := (
        0 => x"00000000",
        1 => x"00000001", 
        2 => x"00000002",
        others => x"FFFFFFFF"
    );
    
    signal addr_int : integer range 0 to 2047;

begin
    addr_int <= to_integer(unsigned(addr));
    
    dout_curr <= rom_matrix(addr_int);
    
    process(addr_int)
    begin
        if addr_int = 0 then
            dout_prev <= (others => '0'); 
        else
            dout_prev <= rom_matrix(addr_int - 1);
        end if;
    end process;

end Behavioral;