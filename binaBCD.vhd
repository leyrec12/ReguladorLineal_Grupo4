----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 20:01:49
-- Design Name: 
-- Module Name: binaBCD - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binaBCD is
   Port ( clk : in std_logic;
           reset : in std_logic;
           Bin : in   STD_LOGIC_VECTOR (13 downto 0);
           Mil : out  STD_LOGIC_VECTOR (3 downto 0);
           Cen : out  STD_LOGIC_VECTOR (3 downto 0);
           Dec : out  STD_LOGIC_VECTOR (3 downto 0);
           Uni : out  STD_LOGIC_VECTOR (3 downto 0);
           dato : in std_logic
           );
end binaBCD;

architecture Behavioral of binaBCD is
    --signal bcd : std_logic_vector(15 downto 0);
begin

process(clk,reset)
    variable z : std_logic_vector(15 downto 0);
    variable b : unsigned(13 downto 0);
    variable i : integer;
begin
        if reset = '1' then
            Mil <= (others=> '0');
            Cen <= (others=> '0');
            Dec <= (others=> '0');
            Uni <= (others=> '0');
            --bcd <= (others => '0');
        elsif clk'event and clk = '1' then
            if dato = '1' then
                b := unsigned(Bin);
                z := (others => '0');
                
                for i in 0 to 13 loop
                
                    if unsigned(z(3 downto 0)) > 4 then
                        z(3 downto 0) := std_logic_vector(unsigned(z(3 downto 0)) + 3);
                    end if;
                    if unsigned(z(7 downto 4)) > 4 then
                        z(7 downto 4) := std_logic_vector(unsigned(z(7 downto 4)) + 3);
                    end if;
                    if unsigned(z(11 downto 8)) > 4 then
                        z(11 downto 8) := std_logic_vector(unsigned(z(11 downto 8)) + 3);
                    end if;
                    if unsigned(z(15 downto 12)) > 4 then
                        z(15 downto 12) := std_logic_vector(unsigned(z(15 downto 12)) + 3);
                    end if;
    
                   
                    z := z(14 downto 0) & b(13);
                    b := b(12 downto 0) & '0';
                end loop;

               -- bcd <= z;
                Uni <= z(3 downto 0);
                Dec  <= z(7 downto 4);
                Cen <= z(11 downto 8);
                Mil <= z(15 downto 12);
      
            end if;
        end if;

end Process;

end Behavioral;