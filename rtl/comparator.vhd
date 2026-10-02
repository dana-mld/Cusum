----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2025 18:33:35
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           treshold: std_logic_vector(15 downto 0);
           a0 : out STD_LOGIC_VECTOR (15 downto 0);
           b0 : out STD_LOGIC_VECTOR (15 downto 0);
           outV : out integer);
end comparator;

architecture Behavioral of comparator is

begin
process(a, b)
begin 
if a>treshold or b>treshold then outV<=1; a0<=X"0000"; b0<=X"0000";
else outV<=0; a0<=a;b0<=b;
end if;
end process;
end Behavioral;
