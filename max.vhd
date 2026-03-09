----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2025 18:32:35
-- Design Name: 
-- Module Name: max - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity max is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           outV : out STD_LOGIC_VECTOR (15 downto 0));
end max;

architecture Behavioral of max is

begin
process(a)
begin 
if a>X"0000" then outV<=a;
else outV<=X"0000";
end if;
end process;

end Behavioral;
