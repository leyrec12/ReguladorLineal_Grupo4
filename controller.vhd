----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2025 16:22:04
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
    generic(
        C_SAMPLE_FREQ       : integer :=  125000000;
        C_CHANNEL_1_ADDR    : std_logic_vector(6 downto 0) := "0010001";
        C_CHANNEL_9_ADDR    : std_logic_vector(6 downto 0) := "0011001"
    );
  Port ( 
    clk_i       : in std_logic;
    rst_i       : in std_logic;
    
    mult_done   : in std_logic;
    
    -- User ports
    start_i     : in std_logic; 
    leds_o      : out std_logic_vector(11 downto 0);
    leds_o_tipo : out std_logic_vector(1 downto 0);
    -- User ports end
 
    -- DRP interface
    do_i        : in std_logic_vector(15 downto 0);
    drdy_i      : in std_logic;
    den_o       : out std_logic;
    daddr_o     : out std_logic_vector(6 downto 0);
    di_o        : out std_logic_vector(15 downto 0);
    dwe_o       : out std_logic
  );
end controller;

architecture Behavioral of controller is

    type State_t is (S_IDLE, S_ACQ, S_WAIT,S_MULT);
    signal STATE            : State_t;
    constant temp_max       : integer := 1000;
    signal temp             : integer range 0 to temp_max;
    signal registro         : std_logic_vector(11 downto 0) := (others => '0');
    signal registro_tipo    : std_logic_vector(1 downto 0);
    signal select_chnl_i    : std_logic;
    signal enable_in        : std_logic;
    constant temp_in_max    : integer := 125000000;
    signal temp_in          : integer range 0 to temp_in_max;
begin

    Maquina : process(clk_i, rst_i)
    begin
        if(rst_i = '1') then
            STATE <= S_IDLE;
            select_chnl_i <= '0';
            leds_o <= (others=>'0');
            leds_o_tipo <= (others=>'0');
        elsif(clk_i'event and clk_i= '1') then
            case STATE is
            
                when S_IDLE =>
                    if(start_i= '1') then
                        STATE<= S_ACQ;
                        den_o <='0';
                    end if;
                    
                when S_ACQ =>
                    STATE <= S_WAIT;
                    den_o <='1';
                    if select_chnl_i='1' then
                        daddr_o <= C_CHANNEL_9_ADDR;
                        registro_tipo <= "10";
                    else
                        daddr_o <= C_CHANNEL_1_ADDR;
                        registro_tipo <= "01";
                    end if;
                    
                when S_WAIT =>
                    den_o <='0';
                    if drdy_i ='1' then
                        leds_o <= do_i(15 downto 4);
                        leds_o_tipo <= registro_tipo;
                        select_chnl_i <= not(select_chnl_i);
                        if registro_tipo="01" then
                            STATE <= S_ACQ;
                        elsif registro_tipo="10" then
                            STATE <= S_MULT;
                        end if;
                    end if;
                    if (temp = temp_max) then
                        STATE <= S_ACQ;
                    end if;  
                 
                 when S_MULT =>
                    if mult_done = '1' then
                        enable_in<='1';
                        leds_o_tipo <= (others=>'0');
                    end if; 
                    
                    if temp_in = temp_in_max then
                        STATE <= S_ACQ;
                        enable_in <='0';
                    end if;
                      
                 when others =>
                    den_o <='0';
            end case;
        end if; 
    end process;
    
    --Contador
    process(clk_i, rst_i)
    begin
        if(rst_i = '1') then
            temp <= 0;
        elsif (clk_i'event and clk_i= '1')  then
            if(STATE = S_WAIT) then 
                if(temp < temp_max) then
                    temp <= temp + 1;
                else
                    temp<= 0;
                end if;
             else 
                  temp <= 0;
            end if;
        end if;
     end process;
     
    --Contador enable_in
    process(clk_i, rst_i)
    begin
        if(rst_i = '1') then
        elsif (clk_i'event and clk_i= '1')  then
            if(temp_in < temp_in_max) and enable_in = '1' then
                    temp_in <= temp_in + 1;
                else
                    temp_in <= 0;
                end if;
        end if;
    end process;

    di_o <= (others => '0');
    dwe_o <= '0';

end Behavioral;
    
