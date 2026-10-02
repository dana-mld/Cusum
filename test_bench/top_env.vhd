-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2025 18:40:45
-- Design Name: 
-- Module Name: top_env - Behavioral
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

entity top_env is
    Port(xt: in std_logic_vector(15 downto 0);
         xt_1: in std_logic_vector(15 downto 0);
         aclk: std_logic;
         rst: std_logic;
         labelT: out std_logic);
end top_env;
architecture Behavioral of top_env is
component comparator is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           treshold: std_logic_vector(15 downto 0);
           a0 : out STD_LOGIC_VECTOR (15 downto 0);
           b0 : out STD_LOGIC_VECTOR (15 downto 0);
           outV : out integer);
end component comparator;

component axis_register_slice_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;

component axis_broadcaster_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axis_tready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end component;

component c_addsub_0
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;

component c_addsub_minus
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    b : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    ce : IN STD_LOGIC;
    s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;

signal reset_n : std_logic;

signal m_axis_tdatas1 : std_logic_vector(15 downto 0);
signal m_axis_tdatas2 : std_logic_vector(15 downto 0);
signal s_axis_tready_slice1 : std_logic;
signal s_axis_tready_slice2 : std_logic;
signal m_axis_tready_broadcaster : std_logic_vector(1 downto 0);
signal m_axis_tvalid_broadcaster : std_logic_vector(1 downto 0);
signal broadcaster_output : std_logic_vector(31 downto 0);

signal ces : std_logic;

signal ss : std_logic_vector(15 downto 0);
signal s_plus_d : std_logic_vector(15 downto 0);
signal g_plus_t1 : std_logic_vector(15 downto 0);
signal g_plus_t : std_logic_vector(15 downto 0);
signal minus_st : std_logic_vector(15 downto 0);
signal s_minus_d : std_logic_vector(15 downto 0);
signal g_minus_t2 : std_logic_vector(15 downto 0);
signal g_minus_t : std_logic_vector(15 downto 0);

signal g_plus_t_1 : std_logic_vector(15 downto 0) := (others => '0');
signal g_minus_t_1 : std_logic_vector(15 downto 0) := (others => '0');

signal g_plus_comp_out : integer;
signal g_minus_comp_out : integer;

constant drift : std_logic_vector(15 downto 0) := X"0001";
constant ts : std_logic_vector(15 downto 0) := X"0064";
constant zero : std_logic_vector(15 downto 0) := (others => '0');

begin

reset_n <= not rst;

ces <= '1';

m_axis_tready_broadcaster <= (others => '1');

c1: axis_register_slice_0
  PORT map(
    aclk => aclk,
    aresetn => reset_n,
    s_axis_tvalid => '1',
    s_axis_tready => s_axis_tready_slice1,
    s_axis_tdata => xt,
    m_axis_tvalid => open,
    m_axis_tready => '1', 
    m_axis_tdata => m_axis_tdatas1
  );

c2: axis_register_slice_0
  PORT map(
    aclk => aclk,
    aresetn => reset_n,
    s_axis_tvalid => '1',
    s_axis_tready => s_axis_tready_slice2,
    s_axis_tdata => xt_1,
    m_axis_tvalid => open,
    m_axis_tready => '1', 
    m_axis_tdata => m_axis_tdatas2
  );

c3: c_addsub_minus
  PORT map(
    A => m_axis_tdatas1,
    B => m_axis_tdatas2,
    CLK => aclk,
    CE => ces,
    S => ss
  );

c4: axis_broadcaster_0
  PORT MAP(
    aclk => aclk,
    aresetn => reset_n,  
    s_axis_tvalid => '1',
    s_axis_tready => open,
    s_axis_tdata => ss,
    m_axis_tvalid => m_axis_tvalid_broadcaster,
    m_axis_tready => m_axis_tready_broadcaster,
    m_axis_tdata => broadcaster_output
  );

c5: c_addsub_minus
  PORT map(
    A => broadcaster_output(15 downto 0),  
    B => drift,
    CLK => aclk,
    CE => ces,
    S => s_plus_d
  );

c6: c_addsub_0
  PORT map(
    A => g_plus_t_1,
    B => s_plus_d,
    CLK => aclk,
    CE => ces,
    S => g_plus_t1
  );

c7: comparator
    PORT MAP(
        a => g_plus_t1,
        b => ZERO,
        treshold => ZERO,
        a0 => g_plus_t,
        b0 => open,
        outV => g_plus_comp_out
    );

c8: c_addsub_minus
  PORT map(
    A => m_axis_tdatas2,
    B => m_axis_tdatas1,
    CLK => aclk,
    CE => ces,
    S => minus_st
  );

c9: c_addsub_minus
  PORT map(
    A => minus_st,
    B => drift,
    CLK => aclk,
    CE => ces,
    S => s_minus_d
  );

c10: c_addsub_0
  PORT map(
    A => g_minus_t_1,
    B => s_minus_d,
    CLK => aclk,
    CE => ces,
    S => g_minus_t
  );

c11: comparator
    PORT MAP(
        a => g_minus_t,
        b => ZERO,
        treshold => ZERO,
        a0 => g_minus_t,
        b0 => open,
        outV => g_minus_comp_out
    );

process(aclk)
begin
    if rising_edge(aclk) then
        if rst = '1' then
            g_plus_t_1 <= (others => '0');
            g_minus_t_1 <= (others => '0');
        elsif ces = '1' then
            g_plus_t_1 <= g_plus_t;
            g_minus_t_1 <= g_minus_t;
        end if;
    end if;
end process;

c12: comparator
    PORT MAP(
        a => g_plus_t,
        b => g_minus_t,
        treshold => ts,
        a0 => open,
        b0 => open,
        outV => open
    );

labelT <= '1' when (g_plus_t > ts) or (g_minus_t > ts) else '0';

end Behavioral;