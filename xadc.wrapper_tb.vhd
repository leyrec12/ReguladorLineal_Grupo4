----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2025 06:04:53 PM
-- Design Name: 
-- Module Name: lab_wrapper_tb - Behavioral
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

entity xadc_wrapper_tb is
--  Port ( );
end xadc_wrapper_tb;

architecture Behavioral of xadc_wrapper_tb is
--Señales en las que luego genero estímulos
    constant CLK_PERIOD     : time := 8 ns;
    signal clk, rst, start  : std_logic;
    signal vaux1_n, vaux1_p : std_logic;
    signal vaux9_n, vaux9_p : std_logic;
    signal segmentos        : std_logic_vector(6 downto 0);
    signal selector         : std_logic_vector(3 downto 0);

begin

    dut : entity work.xadc_wrapper
    port map (
        Vaux1_v_n   => vaux1_n,
        Vaux1_v_p   => vaux1_p,
        Vaux9_v_n   => vaux9_n,
        Vaux9_v_p   => vaux9_p,
        clk         => clk,
        rst         => rst,
        start       => start,
        segmentos   => segmentos,
        selector    => selector
    );

--Señal del reloj
    clk_stimuli : process
    begin
        clk <= '1';
        wait for CLK_PERIOD/2;
        clk <= '0';
        wait for CLK_PERIOD/2;
    end process;
 
 --Estímulos a entradas y salidas   
    dut_stimuli : process
    begin
        rst <= '1';
        start <= '0';
        vaux1_p <= '0';
        vaux1_n <= '0';
        vaux9_p <= '0';
        vaux9_n <= '0';
        wait for 5*CLK_PERIOD;
        
        rst <= '0';
        wait for 5*CLK_PERIOD;
        
        start <= '1';
        wait for CLK_PERIOD;
        start <= '0';
        wait;
    end process;

end Behavioral;
