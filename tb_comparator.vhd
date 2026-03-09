library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_comparator is
end tb_comparator;

architecture simple of tb_comparator is

    component comparator
        Port ( 
            a : in STD_LOGIC_VECTOR (15 downto 0);
            b : in STD_LOGIC_VECTOR (15 downto 0);
            treshold : in STD_LOGIC_VECTOR (15 downto 0);
            a0 : out STD_LOGIC_VECTOR (15 downto 0);
            b0 : out STD_LOGIC_VECTOR (15 downto 0);
            outV : out integer
        );
    end component;

    signal a, b, treshold, a0, b0 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal outV : integer;

begin

    t: comparator port map (
        a => a,
        b => b,
        treshold => treshold,
        a0 => a0,
        b0 => b0,
        outV => outV
    );

    process
    begin
        treshold <= x"0100";
        
        a <= x"00FF";
        b <= x"00FE";
        wait for 10 ns;
        
        a <= x"0101";
        b <= x"00FE";
        wait for 10 ns;
        
        a <= x"00FF";
        b <= x"0101";
        wait for 10 ns;
        
        a <= x"0101";
        b <= x"0102";
        wait for 10 ns;
    
        wait;
    end process;

end simple;