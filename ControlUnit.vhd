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
-- File: ControlUnit.vhd
--
-- Description:
-- The control unit for the NanoCore processor.  The control unit is responsible
-- for generating the proper selection values and enables based on the current
-- cycle and the op code.  It is the state machine for the CPU.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
library work;
use ieee.std_logic_1164.all;
use work.universal.all;

entity ControlUnit is
	port (Carry, Zero : in std_logic;
	CycleBusIn : in std_logic_vector(2 downto 0);
	OpCodeBusIn : in std_logic_vector(4 downto 0);
	OpCodeDone, WriteSelection, AddressLowByteSelection : out std_logic;
	DirectPageSelection : out std_logic_vector(1 downto 0);
	AccumulatorSelection, AddressSelection, PcSelection, StatusSelection, AluSelection : out std_logic_vector(2 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
	ControlUnitOperation : process (Carry, Zero, CycleBusIn, OpCodeBusIn) is
	begin
		case CycleBusIn is
			when OPCODE_CYCLE0 =>
				AccumulatorSelection <= (others => '0');
				AddressLowByteSelection <= '0';
				AddressSelection <= "001";
				AluSelection <= (others => '0');
				DirectPageSelection <= (others => '0');
				OpCodeDone <= '0';
				PcSelection <= "100";
				StatusSelection <= (others => '0');
				WriteSelection <= '0';
			when OPCODE_CYCLE1 =>
				case OpCodeBusIn is
					when ADD_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when SUB_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDP_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ROL_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "011";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when AND_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ORA_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when XOR_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when STA_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '1';
					when DDP_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= "11";
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when IDP_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= "10";
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when CLC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= "101";
						WriteSelection <= '0';
					when SEC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= "110";
						WriteSelection <= '0';
					when ROR_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "111";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when STA_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ADD_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "001";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when SUB_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "010";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when AND_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "100";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ORA_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "101";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when XOR_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "110";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= "001";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "001";
						WriteSelection <= '0';
					when JMP_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BCC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BCS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDP_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= "01";
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BZC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BZS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when JSR_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "101";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '1';
					when RTS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "100";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when STA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when OPCODE_CYCLE2 =>
				case OpCodeBusIn is
					when ADD_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "001";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when SUB_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "010";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDP_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "110";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ROL_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "011";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= "011";
						WriteSelection <= '0';
					when AND_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "100";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ORA_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "101";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when XOR_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "110";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_DIRECT_OPCODE =>
						AccumulatorSelection <= "001";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "001";
						WriteSelection <= '0';
					when STA_DIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when ROR_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= "111";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= "011";
						WriteSelection <= '0';
					when LDA_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "110";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when STA_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "110";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '1';
					when ADD_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= "011";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "100";
						WriteSelection <= '0';
					when SUB_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= "011";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "100";
						WriteSelection <= '0';
					when AND_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= "100";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "010";
						WriteSelection <= '0';
					when ORA_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= "101";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "010";
						WriteSelection <= '0';
					when XOR_IMMEDIATE_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= "110";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "010";
						WriteSelection <= '0';
					when JMP_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "011";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BCC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						if Carry = '0' then
							PcSelection <= "011";
						else
							PcSelection <= (others => '0');
						end if;
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BCS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						if Carry = '1' then
							PcSelection <= "011";
						else
							PcSelection <= (others => '0');
						end if;
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BZC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						if Zero = '0' then
							PcSelection <= "011";
						else
							PcSelection <= (others => '0');
						end if;
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BZS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						if Zero = '1' then
							PcSelection <= "011";
						else
							PcSelection <= (others => '0');
						end if;
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when JSR_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when RTS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '1';
						AddressSelection <= "011";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "110";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when STA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "110";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when OPCODE_CYCLE3 =>
				case OpCodeBusIn is
					when ADD_DIRECT_OPCODE =>
						AccumulatorSelection <= "011";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "100";
						WriteSelection <= '0';
					when SUB_DIRECT_OPCODE =>
						AccumulatorSelection <= "011";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "100";
						WriteSelection <= '0';
					when LDP_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= "01";
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when AND_DIRECT_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= "100";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "010";
						WriteSelection <= '0';
					when ORA_DIRECT_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= "101";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "010";
						WriteSelection <= '0';
					when XOR_DIRECT_OPCODE =>
						AccumulatorSelection <= "010";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= "110";
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "010";
						WriteSelection <= '0';
					when LDA_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= "001";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "001";
						WriteSelection <= '0';
					when STA_ABSOLUTE_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when JMP_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BCC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BCS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BZC_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when BZS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when JSR_OPCODE =>
						AccumulatorSelection <= "101";
						AddressLowByteSelection <= '0';
						AddressSelection <= "011";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "010";
						StatusSelection <= (others => '0');
						WriteSelection <= '1';
					when RTS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "011";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when STA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "010";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '1';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when OPCODE_CYCLE4 =>
				case OpCodeBusIn is
					when JSR_OPCODE =>
						AccumulatorSelection <= "100";
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= "001";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when RTS_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when LDA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= "001";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= "001";
						WriteSelection <= '0';
					when STA_DIRECT_INDIRECT_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when OPCODE_CYCLE5 =>
				case OpCodeBusIn is
					when JSR_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "100";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '1';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when OPCODE_CYCLE6 =>
				case OpCodeBusIn is
					when JSR_OPCODE =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= "101";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '0';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when OPCODE_CYCLE7 =>
				case OpCodeBusIn is
					when JSR_OPCODE =>
						AccumulatorSelection <= "001";
						AddressLowByteSelection <= '0';
						AddressSelection <= "001";
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= "100";
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
					when others =>
						AccumulatorSelection <= (others => '0');
						AddressLowByteSelection <= '0';
						AddressSelection <= (others => '0');
						AluSelection <= (others => '0');
						DirectPageSelection <= (others => '0');
						OpCodeDone <= '1';
						PcSelection <= (others => '0');
						StatusSelection <= (others => '0');
						WriteSelection <= '0';
				end case;
			when others =>
				AccumulatorSelection <= (others => '0');
				AddressLowByteSelection <= '0';
				AddressSelection <= (others => '0');
				AluSelection <= (others => '0');
				DirectPageSelection <= (others => '0');
				OpCodeDone <= '1';
				PcSelection <= (others => '0');
				StatusSelection <= (others => '0');
				WriteSelection <= '0';
		end case;
	end process ControlUnitOperation;
end Behavioral;
