library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sub is
end tb_sub;

architecture simple of tb_sub is

    component c_addsub_minus
        Port ( 
            a : in STD_LOGIC_VECTOR (15 downto 0);
            b : in STD_LOGIC_VECTOR (15 downto 0);
            clk : in STD_LOGIC;
            ce : in STD_LOGIC;
            s : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal ce : STD_LOGIC := '0';
    signal a, b, s : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    
    constant CLK_PERIOD : time := 10 ns;

begin

    t: c_addsub_minus port map (
        A => a,
        B => b,
        CLK => clk,
        CE => ce,
        S => s
    );

    clk <= not clk after CLK_PERIOD/2;

    process
    begin
        wait for 100 ns;
        
        ce <= '1';
        a <= x"0005";
        b <= x"0003";
        wait until rising_edge(clk);
        
        a <= x"0010";
        b <= x"0005";
        wait until rising_edge(clk);
        
        a <= x"0003";
        b <= x"0005";
        wait until rising_edge(clk);
      
        ce <= '0';
        wait for 100 ns;
                wait;
    end process;

end simple;