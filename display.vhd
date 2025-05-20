----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 20:02:27
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is
  Port (
    clk         : in std_logic;
    reset       : in std_logic;
    unidades    : in std_logic_vector(3 downto 0);
    decenas     : in std_logic_vector(3 downto 0);
    centenas    : in std_logic_vector(3 downto 0);
    miles       : in std_logic_vector(3 downto 0);
    segmentos_o : out std_Logic_vector(6 downto 0);
    selector_o  : out std_logic_vector(3 downto 0)
   );
end display;

architecture Behavioral of display is
    constant count_max_4khz     : integer := 125000000/4000;
    signal count_4khz           : integer range 0 to count_max_4khz;
    signal display_counter_en   : std_logic;
    signal mycount              : unsigned(1 downto 0);
    signal BCD_digit            : std_logic_vector(3 downto 0);
begin
    
    process(clk,reset)
    begin
        if reset = '1' then
            count_4khz <= 0;
        elsif clk'event and clk = '1' then
             if count_4khz = count_max_4khz-1 then
                count_4khz <= 0;
             else
                count_4khz<= count_4khz + 1;
             end if;
        end if;
    end process;
         
    display_counter_en <='1' when (count_4khz = count_max_4khz - 1) else '0';
        
    process(clk,reset)
    begin
        if reset = '1' then
            mycount<="00";
        
        elsif clk'event and clk = '1' then
        
            if display_counter_en ='1' then
            
               if mycount = "11" then
                    mycount<= "00";
               else 
                   mycount<= mycount + 1;
               end if;
            end if;
       end if;
    end process;
    
    process (mycount, unidades, decenas, centenas, miles)
    begin
        case mycount is
           when "00" =>
               selector_o <= "1000";
               BCD_digit <= miles;
           when "01" =>
               selector_o <= "0100";
               BCD_digit <= centenas;
           when "10" =>
               selector_o <= "0010";
               BCD_digit <= decenas;
           when "11"=>
               selector_o <= "0001";
               BCD_digit <= unidades;
           when others =>
               selector_o <= "1111";
               BCD_digit <= "0001";       
        end case;
    end process;
    
    segmentos_o <=  "0000001" when BCD_digit="0000" else -- 0
                    "1001111" when BCD_digit="0001" else -- 1
                    "0010010" when BCD_digit="0010" else -- 2
                    "0000110" when BCD_digit="0011" else -- 3
                    "1001100" when BCD_digit="0100" else -- 4
                    "0100100" when BCD_digit="0101" else -- 5
                    "0100000" when BCD_digit="0110" else -- 6
                    "0001111" when BCD_digit="0111" else -- 7
                    "0000000" when BCD_digit="1000" else -- 8
                    "0000100" when BCD_digit="1001" else -- 9
                    "1111111";

end Behavioral;
