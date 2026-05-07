----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal w_result : std_logic_vector(8 downto 0) := (others => '0');

begin
    process(i_A, i_B, i_op)
    begin
        case i_op is
            when "000" => -- Add
                w_result <= std_logic_vector(resize(unsigned(i_A), 9) + resize(unsigned(i_B), 9)); -- Resisze in case two 8 bits are added together. Unsigned to force a data type.
            when "001" => -- Subtract
                w_result <= std_logic_vector(resize(unsigned(i_A), 9) + resize(unsigned(not i_B), 9) + 1); -- I was getting an error on this in github. Trying to fix
            when "010" => -- And
                w_result <= '0' & (i_A and i_B); -- '0' to force a 9 bit value
            when "011" => -- Or
                w_result <= '0' & (i_A or i_B); -- same here
            when others =>
                w_result <= (others => '0');
        end case;
    end process;
    
    o_result <= w_result(7 downto 0);
    
    -- NZCV Flags
    o_flags(3) <= w_result(7); -- MSB of the 8-bit result N
    o_flags(2) <= '1' when w_result(7 downto 0) = "00000000" else '0'; -- Turn on when all zeroes Z
    o_flags(1) <= w_result(8); -- Unsigned Overflow       C
    -- Need two conditions, one for addition one for subtraction.
    -- Addition overflow: A and B signs match but result is different.
    -- Subtraction overflow: A and B signs different and result is B's sign.
    o_flags(0) <= '1' when (i_op = "000" and (i_A(7) = i_B(7)) and (w_result(7) /= i_A(7))) else -- Addition
                  '1' when (i_op = "001" and (i_A(7) /= i_B(7)) and (w_result(7) /= i_A(7))) else -- Subtraction
                  '0';
end Behavioral;
