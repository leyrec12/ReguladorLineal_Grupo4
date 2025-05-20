----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 20:01:00
-- Design Name: 
-- Module Name: mult - Behavioral
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

entity mult is
    Port (
        clk           : in std_logic;
        reset         : in std_logic;
        entrada       : in std_logic_vector(11 downto 0);
        entrada_tipo  : in std_logic_vector (1 downto 0);
        resultado     : out std_logic_vector(13 downto 0);
        terminado     : out std_logic
    );
end mult;

architecture Behavioral of mult is
    type State_t is (IDLE, MULT_1, MULT_2);
    signal STATE : State_t;
    signal Acc : unsigned(12 downto 0);
    signal A   : unsigned(12 downto 0);   --multiplicando (V)
    signal Q   : unsigned(12 downto 0);   --multiplicador (I)
    signal Q1 : std_logic := '0';
    constant n_max :integer:=13;
    signal n : integer range 0 to n_max := 0; -- cuenta hasta el numero de bits+1
    constant m_max :integer:=2;
    signal m : integer range 0 to m_max := 0; -- cuenta las 3 operaciones de cada ciclo
    constant v_max : integer:=1;
    signal v : integer range 0 to v_max;
    signal cond : std_logic_vector(1 downto 0):= "00";
    signal result_int : std_logic_vector(25 downto 0);
    constant K : unsigned(12 downto 0) := "0001010011011";

begin
    process(clk, reset)
    begin
        if reset = '1' then
            STATE <= IDLE;
            Acc <= (others => '0');
            A   <= (others => '0');
            Q   <= (others => '0');
            Q1 <= '0';
            n <= 0;
            m <= 0;
            v <= 0;
            cond <= "00";
            result_int <= (others => '0');
        elsif (clk'event and clk = '1') then
            
            case STATE is
            
                when IDLE =>
                
                    if entrada_tipo = "01" then
                        A <= unsigned("0" & entrada);
                    elsif entrada_tipo = "10" then
                        Q <= unsigned("0" & entrada);
                        STATE <= MULT_1;
                    else
                        STATE <= IDLE;
                    end if;
                    
                when MULT_1 =>
                    if n = n_max then 
                        if v = v_max then
                            STATE <= IDLE;
                            v <= 0;
                            n <= 0;
                            m <= 0;
                        else
                            result_int <= std_logic_vector(Acc & Q);
                            STATE <= MULT_2;
                            v <= v+1;
                        end if;
                        n<=0;
                    else
                        case m is
                            when 0 =>
                                cond <= Q(0) & Q1;
                                m <= m+1;
                            when 1 =>
                                case cond is
                                    when "01" =>
                                        Acc <= Acc + A;
                                    when "10" =>
                                        Acc <= Acc + not(A)+"000000000001";
                                    when others =>
                                        Acc <= Acc;
                                end case;
                                m <= m+1;
                            when 2 =>
                                -- Desplazamiento
                                Q1 <= Q(0);
                                Q   <= Acc(0) & Q(12 downto 1);
                                Acc <= Acc(12) & Acc(12 downto 1);
                                m <= 0;
                                n <= n+1;
                            when others =>
                                Acc <= (others => '0');
                                A   <= (others => '0');
                                Q   <= (others => '0');
                                Q1 <= '0';
                                n <= 0;
                                cond <= "00";
                            end case;
                    end if;
                
                when MULT_2 =>
                    A <= unsigned(result_int(24 downto 12));
                    Q <= K;
                    Acc <= (others => '0');
                    Q1 <= '0';
                    n <= 0;
                    m <= 0;
                    cond <= "00";
                    STATE <= MULT_1;
                    
                when others =>
                    STATE <= IDLE;
            end case;
                
            
            
        end if;
    end process;
    
    resultado <= std_logic_vector(Acc & Q(12)) when v=v_max and n=n_max else (others => '0') ;
    terminado <= '1' when v=v_max and n=n_max else '0';
end Behavioral;

