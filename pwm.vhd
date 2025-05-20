----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 20:31:00
-- Design Name: 
-- Module Name: pwm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
  Port ( 
    clk         : in std_logic; -- Reloj de 125 MHz
    reset       : in std_logic;
    pwm_out     : out std_logic 
  );
end pwm;

architecture Behavioral of pwm is
    
    constant pwm_period     : integer := 1250000; -- 10 ms a 125 MHz
    constant step_size      : integer := 4883; -- pwm_period / 256
    signal pwm_counter      : integer range 0 to pwm_period - 1;
    signal duty_threshold   : integer range 0 to pwm_period - 1;
    constant duty_cycle     : integer := 250;  -- Valor del duty (0 a 255)
begin

    pwm_contador : process(clk, reset)
    begin
        if (reset = '1') then 
            pwm_counter <= 0;
            duty_threshold <= 0;
        elsif (clk'event and clk = '1') then
            -- Actualizción del contador
            if pwm_counter < pwm_period - 1 then
                pwm_counter <= pwm_counter + 1;
            else
                pwm_counter <= 0;
            end if;
            
            -- Cálculo del umbral de comparación
            duty_threshold <= duty_cycle * step_size;
        end if;
    end process;    
    
    -- Asignación de salida PWM
    pwm_out <= '1' when pwm_counter < duty_threshold else '0';
    
end Behavioral;