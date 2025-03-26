-- Title : HELO world!
-- Author : Albert Chiang
-- Date : 2024/AUG/02
-- Description : Displays "HELO" to a Basys3 board
-- and show how 2 files 1) this VHDL 2) XDC files
-- are needed to make this work.
-- Also trying to use most used VHDL constructs
-- entity, port, architecture, process, rising_edge
-- if, elsif, endif, case, endcase,
-- variable, generic, continuos signal assigment,
-- conditional sigement assignment (when), others


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity hello_world is
    generic  (
        UPPER : natural := 20;
        LOWER : natural := 19
    ); -- generic
            
    Port ( 
        clk     : in  std_logic;
        seg7    : out std_logic_vector(6 downto 0);
        an      : out std_logic_vector(3 downto 0);
        leds    : out std_logic_vector(2 downto 0)       
        
                        
    ); -- Port
end hello_world;

architecture Behavioral of hello_world is

signal cnt          : unsigned(31 downto 0) := (others => '0');
signal cnt_upper    : unsigned(1 downto 0);

begin


-- continuous signal assigment (CSA)
cnt_upper <= cnt(UPPER downto LOWER); 

-- conditional signal assigement
leds(2) <= '0' when cnt(30) = '1' else
           '1' when cnt(30) = '0' else
           'X'; 



-- a process duplicating a CSA
process_csa : process (cnt) 

    variable vloopcnt : integer := 0; 
    
    begin

    case cnt(26) is 
        when '0' => 
            leds(0) <= '0';
            vloopcnt := vloopcnt + 1;
        when '1' => leds(0) <= '1';
        when others => leds(2) <= '0'; -- 'x';
        
    end case;
    
end process; -- process_csa

process_if : process (cnt) 
    
    begin
    
    if cnt(28) = '0' then
        leds(0) <= '0';
    elsif cnt(28) = '1' then
        leds(1) <= '1';    
    else
        leds(1) <= 'X';
    end if;     

    
end process; -- process_if

-- This process is a clocked infinite loop 
-- that increments unsigned (31 downto 0) varialbe "cnt".
-- Looking at bits (20 downto 19) of cnt, I created four phases
-- responsible for driving 'H', 'E', 'L', or 'O';
        
process_time_wheel : process (clk) 

variable vuppercnt : integer := 0;

begin

    
    if(rising_edge (clk) ) then
        cnt <= cnt + 1;
        case cnt_upper is -- case cnt(20 downto 19) is
            when "00" =>
                seg7 <= "1000000"; -- O
                an <= x"e"; --"1110";
                vuppercnt := vuppercnt + 1;

            when "01" =>
                seg7 <= "1000111"; -- L
                an <= "1101";
            when "10" =>
                seg7 <= "0000110"; -- E
                an <= "1011";
            when "11" => --x"3" 
                seg7 <= "0001001"; -- H
                an <= "0111";

        end case;
    end if; -- clk
end process; -- process_time_wheel
end Behavioral;
