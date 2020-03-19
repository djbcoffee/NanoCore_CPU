---------------------------------------------------------------------------------
-- Copyright (C) 2014 Donald J. Bartley <djbcoffee@gmail.com>
--
-- This source file may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains the original copyright notice and the associated disclaimer.
--
-- This source file is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation; either version 2 of the License, or (at your option) any
-- later version.
--
-- This source file is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
-- details.
--
-- You should have received a copy of the GNU General Public License along with
-- this source file.  If not, see <http://www.gnu.org/licenses/> or write to the
-- Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-- 02110-1301, USA.
---------------------------------------------------------------------------------
-- File: Universal.vhd
--
-- Description:
-- Contains universal information for the project.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package Universal is
	--Op codes:
	constant ADD_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "00000";
	constant SUB_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "00001";
	constant LDP_ABSOLUTE_OPCODE : std_logic_vector(4 downto 0) := "00010";
	constant ROL_OPCODE : std_logic_vector(4 downto 0) := "00011";
	constant AND_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "00100";
	constant ORA_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "00101";
	constant XOR_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "00110";
	constant LDA_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "00111";
	constant STA_DIRECT_OPCODE : std_logic_vector(4 downto 0) := "01000";
	constant DDP_OPCODE : std_logic_vector(4 downto 0) := "01001";
	constant IDP_OPCODE : std_logic_vector(4 downto 0) := "01010";
	constant CLC_OPCODE : std_logic_vector(4 downto 0) := "01011";
	constant SEC_OPCODE : std_logic_vector(4 downto 0) := "01100";
	constant ROR_OPCODE : std_logic_vector(4 downto 0) := "01101";
	constant LDA_ABSOLUTE_OPCODE : std_logic_vector(4 downto 0) := "01110";
	constant STA_ABSOLUTE_OPCODE : std_logic_vector(4 downto 0) := "01111";
	constant ADD_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "10000";
	constant SUB_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "10001";
	constant AND_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "10010";
	constant ORA_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "10011";
	constant XOR_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "10100";
	constant LDA_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "10101";
	constant JMP_OPCODE : std_logic_vector(4 downto 0) := "10110";
	constant BCC_OPCODE : std_logic_vector(4 downto 0) := "10111";
	constant BCS_OPCODE : std_logic_vector(4 downto 0) := "11000";
	constant LDP_IMMEDIATE_OPCODE : std_logic_vector(4 downto 0) := "11001";
	constant BZC_OPCODE : std_logic_vector(4 downto 0) := "11010";
	constant BZS_OPCODE : std_logic_vector(4 downto 0) := "11011";
	constant JSR_OPCODE : std_logic_vector(4 downto 0) := "11100";
	constant RTS_OPCODE : std_logic_vector(4 downto 0) := "11101";
	constant LDA_DIRECT_INDIRECT_OPCODE : std_logic_vector(4 downto 0) := "11110";
	constant STA_DIRECT_INDIRECT_OPCODE : std_logic_vector(4 downto 0) := "11111";
	
	--Op code cycles:
	constant OPCODE_CYCLE0 : std_logic_vector(2 downto 0) := "000";
	constant OPCODE_CYCLE1 : std_logic_vector(2 downto 0) := "001";
	constant OPCODE_CYCLE2 : std_logic_vector(2 downto 0) := "010";
	constant OPCODE_CYCLE3 : std_logic_vector(2 downto 0) := "011";
	constant OPCODE_CYCLE4 : std_logic_vector(2 downto 0) := "100";
	constant OPCODE_CYCLE5 : std_logic_vector(2 downto 0) := "101";
	constant OPCODE_CYCLE6 : std_logic_vector(2 downto 0) := "110";
	constant OPCODE_CYCLE7 : std_logic_vector(2 downto 0) := "111";
end package Universal;

package body Universal is

end package body Universal;
