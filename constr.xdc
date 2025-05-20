## Debéis comentar las lineas que tengan puertos de entrada/salida que no utilicéis

## Clock
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {clk}];

# Entrada analogica del pin A0
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {Vaux1_v_p}];
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {Vaux1_v_n}];

# Entrada analogica del pin A1
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {Vaux9_v_p}];
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {Vaux9_v_n}];

## Botones de la PYNQ-Z2
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports {rst}];
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports {start}];

## LEDs de la PYNQ-Z2
#set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {leds_pynq[0]}];
#set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {leds_pynq[1]}];
#set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {leds_pynq[2]}];
#set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {leds_pynq[3]}];

## LEDs de la placa de expansión
#set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33}  [get_ports {shield_leds[0]}];
#set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33}  [get_ports {shield_leds[1]}];
#set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33}  [get_ports {shield_leds[2]}]; 
#set_property -dict {PACKAGE_PIN U7  IOSTANDARD LVCMOS33}  [get_ports {shield_leds[3]}]; 
#set_property -dict {PACKAGE_PIN V7  IOSTANDARD LVCMOS33}  [get_ports {shield_leds[4]}];
#set_property -dict {PACKAGE_PIN U8  IOSTANDARD LVCMOS33}  [get_ports {shield_leds[5]}];
#set_property -dict {PACKAGE_PIN V8  IOSTANDARD LVCMOS33}  [get_ports {shield_leds[6]}]; 
#set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33}  [get_ports {shield_leds[7]}];

## Displays selectors de la placa de expansión
set_property -dict {PACKAGE_PIN F20   IOSTANDARD LVCMOS33} [get_ports {selector[0]}]; # Disp4
set_property -dict {PACKAGE_PIN U19   IOSTANDARD LVCMOS33} [get_ports {selector[1]}]; # Disp3
set_property -dict {PACKAGE_PIN B19   IOSTANDARD LVCMOS33} [get_ports {selector[2]}]; # Disp2
set_property -dict {PACKAGE_PIN B20   IOSTANDARD LVCMOS33} [get_ports {selector[3]}]; # Disp1

## Segments de la placa de expansión
set_property -dict {PACKAGE_PIN Y7    IOSTANDARD LVCMOS33} [get_ports {segmentos[0]}]; #--24 segment 0 (g)
set_property -dict {PACKAGE_PIN A20   IOSTANDARD LVCMOS33} [get_ports {segmentos[1]}]; #--20 segment 1 (f)
set_property -dict {PACKAGE_PIN V6    IOSTANDARD LVCMOS33} [get_ports {segmentos[2]}]; #--14 segment 2 (e)
set_property -dict {PACKAGE_PIN Y6    IOSTANDARD LVCMOS33} [get_ports {segmentos[3]}]; #--15 segment 3 (d)
set_property -dict {PACKAGE_PIN W6    IOSTANDARD LVCMOS33} [get_ports {segmentos[4]}]; #--23 segment 4 (c)
set_property -dict {PACKAGE_PIN F19   IOSTANDARD LVCMOS33} [get_ports {segmentos[5]}]; #--23 segment 4 (c)
set_property -dict {PACKAGE_PIN Y9    IOSTANDARD LVCMOS33} [get_ports {segmentos[6]}]; #--21 segment 6 (a)

#PWM
set_property -dict {PACKAGE_PIN T14    IOSTANDARD LVCMOS33} [get_ports {pwm}]; #AR0

## Switches de la placa de expansión
#set_property -dict {PACKAGE_PIN W8    IOSTANDARD LVCMOS33} [get_ports {shield_switches[0]}];
#set_property -dict {PACKAGE_PIN Y8    IOSTANDARD LVCMOS33} [get_ports {shield_switches[1]}];
#set_property -dict {PACKAGE_PIN W9    IOSTANDARD LVCMOS33} [get_ports {shield_switches[2]}];
#set_property -dict {PACKAGE_PIN Y17   IOSTANDARD LVCMOS33} [get_ports {shield_switches[3]}];

## Los botones de la placa de expansión están mal soldados y no se pueden utilizar