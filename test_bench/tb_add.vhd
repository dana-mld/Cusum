library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_add is
end tb_add;

architecture simple of tb_add is

    component c_addsub_0
        Port ( 
            A : in STD_LOGIC_VECTOR (15 downto 0);
            B : in STD_LOGIC_VECTOR (15 downto 0);
            CLK : in STD_LOGIC;
            CE : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal ce : STD_LOGIC := '0';
    signal a, b, s : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    
    constant CLK_PERIOD : time := 10 ns;

begin

    t: c_addsub_0 port map (
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
        b <= x"0020";
        wait until rising_edge(clk);
        
        a <= x"7FFF";
        b <= x"0001";
        wait until rising_edge(clk);
        
        
        ce <= '0';
        wait for 100 ns;
                wait;
    end process;

end simple;