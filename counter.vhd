----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2025 16:22:38
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (10 downto 0));
end counter;

architecture Behavioral of counter is
    signal addr_reg : unsigned(10 downto 0);  
begin
    process(clk, rst)
    begin
        if rst = '1' then  
            addr_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then 
                addr_reg <= addr_reg + 1;
            end if;
        end if;
    end process;
    
    addr <= std_logic_vector(addr_reg);  

end Behavioral;