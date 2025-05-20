----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2025 16:03:48
-- Design Name: 
-- Module Name: xadc_wrapper - Behavioral
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

entity xadc_wrapper is
  Port ( 
    clk : in std_logic;
    rst : in std_logic;
    
    Vaux1_v_n : in std_logic;
    Vaux1_v_p : in std_logic;
    Vaux9_v_n : in std_logic;
    Vaux9_v_p : in std_logic;
    
    segmentos : out std_logic_vector(6 downto 0);
    selector : out std_logic_vector(3 downto 0);
    
    pwm : out std_logic;
    start : in std_logic
  );
end xadc_wrapper;

architecture Behavioral of xadc_wrapper is

    constant zero : std_logic :='0';
    signal di, do : std_logic_vector(15 downto 0 );
    signal daddr : std_logic_vector(6 downto 0 );
    signal den, dwe, drdy : std_logic;
    signal leds : std_logic_vector(11 downto 0);
    signal leds_tipo : std_logic_vector (1 downto 0);
    signal potencia : std_logic_vector (13 downto 0);
    signal done : std_logic;
    signal unidades_i, decenas_i, centenas_i, miles_i : std_logic_vector(3 downto 0);
    
begin
    controller_inst: entity work.controller
        PORT MAP (
            clk_i => clk,
            daddr_o => daddr,
            den_o => den,
            di_o => di,  
            do_i => do,
            drdy_i => drdy,
            dwe_o => dwe,
            leds_o => leds,
            leds_o_tipo => leds_tipo,
            rst_i => rst,
            start_i => start,
            mult_done => done
        );

    xadc_inst : entity work.xadc_wiz_0
      PORT MAP (
        di_in => di,
        daddr_in => daddr,
        den_in => den,
        dwe_in => dwe,
        drdy_out => drdy,
        do_out => do,
        dclk_in => clk,
        reset_in => rst,
        vp_in => zero,
        vn_in => zero,
        vauxp1 => Vaux1_v_p,
        vauxn1 => Vaux1_v_n,
        vauxp9  => Vaux9_v_p,
        vauxn9  => Vaux9_v_n,
        channel_out => open,
        eoc_out => open,
        alarm_out => open,
        eos_out => open,
        busy_out => open
      );
      
mult_inst : entity work.mult
    PORT MAP(
        clk  => clk,        
        reset   => rst,     
        entrada   => leds,   
        entrada_tipo => leds_tipo,
        resultado   => potencia,
        terminado   => done
    );

binaBCD_inst : entity work.binaBCD
    PORT MAP(
        clk => clk,
        reset => rst,
        Bin => potencia,
        Mil => miles_i,
        Cen => centenas_i,
        Dec => decenas_i,
        Uni => unidades_i,
        dato => done
    );
    
display_inst : entity work.display
    PORT MAP(
        clk => clk,
        reset => rst,
        unidades => unidades_i,
        decenas => decenas_i,
        centenas => centenas_i,
        miles => miles_i,
        segmentos_o => segmentos,
        selector_o => selector
    );
    
pwm_inst : entity work.pwm
    PORT MAP(
        clk => clk,
        reset => rst,
        pwm_out => pwm
    );
end Behavioral;
