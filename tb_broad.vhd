library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_broad is
end tb_broad;

architecture simple of tb_broad is

    component axis_broadcaster_0
        Port ( 
            aclk : in STD_LOGIC;
            aresetn : in STD_LOGIC;
            s_axis_tvalid : in STD_LOGIC;
            s_axis_tready : out STD_LOGIC;
            s_axis_tdata : in STD_LOGIC_VECTOR (15 downto 0);
            m_axis_tvalid : out STD_LOGIC_VECTOR (1 downto 0);
            m_axis_tready : in STD_LOGIC_VECTOR (1 downto 0);
            m_axis_tdata : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal resetn : STD_LOGIC := '0';
    signal s_valid, s_ready : STD_LOGIC := '0';
    signal s_data : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal m_valid : STD_LOGIC_VECTOR(1 downto 0);
    signal m_ready : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal m_data : STD_LOGIC_VECTOR(31 downto 0);
    
    constant CLK_PERIOD : time := 10 ns;

begin

    t: axis_broadcaster_0 port map (
        aclk => clk,
        aresetn => resetn,
        s_axis_tvalid => s_valid,
        s_axis_tready => s_ready,
        s_axis_tdata => s_data,
        m_axis_tvalid => m_valid,
        m_axis_tready => m_ready,
        m_axis_tdata => m_data
    );

    clk <= not clk after CLK_PERIOD/2;

    process
    begin
        resetn <= '0';
        wait for 100 ns;
        resetn <= '1';
        wait for 20 ns;
        
        m_ready <= "11";
        s_valid <= '1';
        s_data <= x"1234";
        wait until rising_edge(clk) and s_ready = '1';
        
        s_data <= x"5678";
        wait until rising_edge(clk) and s_ready = '1';
        
        s_valid <= '0';
        wait for 100 ns;
        
        wait;
    end process;

end simple;