----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2025 16:40:22
-- Design Name: 
-- Module Name: cusum_bsy - Behavioral
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

entity cusum_bsy is
    Port ( btn_inc : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end cusum_bsy;

architecture Behavioral of cusum_bsy is
component counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (10 downto 0));
end component counter;

component debouncer is
  Port ( clk : in std_logic;
        btn : in std_logic;
        en : out std_logic );
end component debouncer;

component top_env is
    Port(xt: in std_logic_vector(15 downto 0);
         xt_1: in std_logic_vector(15 downto 0);
         aclk: std_logic;
         rst: std_logic;
         labelT: out std_logic);
end component top_env;

component ram is
    Port ( addr : in STD_LOGIC_VECTOR (10 downto 0);
           dout_curr : out STD_LOGIC_VECTOR (31 downto 0);
           dout_prev : out STD_LOGIC_VECTOR (31 downto 0));
end component ram;

component display_7seg is
    Port ( digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component display_7seg;
signal sen, lbl: std_logic;
signal addrs, x1, x2: std_logic_vector(10 downto 0);
signal lo, l1, l2, l3: std_logic_vector(3 downto 0);

begin
c1: debouncer 
  Port map  ( clk => clk,
        btn  =>btn_inc,
        en  => sen
         );
c2:  counter 
    Port map ( clk => clk,
           rst => rst, 
           en => sen,
           addr => addrs);

c4:  top_env 
    Port map(xt => x1,
         xt_1 => x2,
         aclk => clk,
         rst => rst,
         labelT => lbl);
         
c3: ram 
    Port map( addr =>addrs,
           dout_curr =>x1,
           dout_prev =>x2);
lo<=lbl & "000";
c5:   display_7seg 
    Port map( digit0 => l1,
           digit1 => l2,
           digit2 => l3,
           digit3 => lo,
           clk => clk,
           cat=> cat,
           an =>an);
end Behavioral;
