----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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

entity controller_fsm is
    Port ( clk     : in STD_LOGIC;
           i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is
    type state_type is (s_RESET, s_LOAD1, s_LOAD2, s_RESULT); -- Custom names for the states of the FSM
    signal current_state, next_state : state_type := s_RESET; -- Signals to hold current and next state

begin
    process(clk) -- Clock and synchronous reset
    begin
        if rising_edge(clk) then
            if i_reset = '1' then
                current_state <= s_RESET;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;
    
    -- Need Next State Logic
    process(current_state, i_adv)
    begin
        next_state <= current_state; -- Stay on current state unless something changes
        case current_state is -- FSM per the drawing I made for the prelab
            when s_RESET =>
                if i_adv = '1' then
                    next_state <= s_LOAD1;
                end if;
            when s_LOAD1 =>
                if i_adv = '1' then
                    next_state <= s_LOAD2;
                end if;
            when s_LOAD2 =>
                if i_adv = '1' then
                    next_state <= s_RESULT;
                end if;
            when s_RESULT =>
                if i_adv = '1' then
                    next_state <= s_RESET; -- Loop back to beginning
                end if;
        end case;
    end process;
    
    -- Output Logic
    process(current_state)
    begin
        case current_state is
            when s_RESET =>
                o_cycle <= "0001";
            when s_LOAD1 =>
                o_cycle <= "0010";
            when s_LOAD2 =>
                o_cycle <= "0100";
            when s_RESULT =>
                o_cycle <= "1000";
            when others =>
                o_cycle <= "0001"; -- Default to s_RESET
        end case;
    end process;
end FSM;
