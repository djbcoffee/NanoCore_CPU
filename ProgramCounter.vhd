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
-- File: ProgramCounter.vhd
--
-- Description:
-- The program counter for the NanoCore processor.  The program counter holds the
-- current op code address being accessed by the CPU.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProgramCounter is
	port (Clock, ResetSignal : in std_logic;
	PcSelection : in std_logic_vector(2 downto 0);
	DataBusIn, AddressLowByteIn : in std_logic_vector(7 downto 0);
	ProgramCounterOut : out std_logic_vector(15 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is
begin
	ProgramCounterOperation : process (Clock) is
		variable programCounterRegister : std_logic_vector(15 downto 0) := (others => '0');
	begin
		if Clock'event and Clock = '1' then
			if ResetSignal = '1' then
				--0 - Do nothing.
				--1 - Load the counter least significant byte from the buffer.
				--2 - Load the counter most significant byte from the data bus.
				--3 - Load both the least and most significant bytes.
				--4 - Increment the counter.
				if unsigned(PcSelection) = 4 then
					programCounterRegister := std_logic_vector(unsigned(programCounterRegister) + 1);
				elsif unsigned(PcSelection) = 1 then
					programCounterRegister(7 downto 0) := AddressLowByteIn;
				elsif unsigned(PcSelection) = 2 then
					programCounterRegister(15 downto 8) := DataBusIn;
				elsif unsigned(PcSelection) = 3 then
					programCounterRegister(7 downto 0) := AddressLowByteIn;
					programCounterRegister(15 downto 8) := DataBusIn;
				else
					programCounterRegister := programCounterRegister;
				end if;
			else
				programCounterRegister := (others => '0');
			end if;
		end if;
		
		--Put the output of the register onto the internal bus.
		ProgramCounterOut <= programCounterRegister;
	end process ProgramCounterOperation;
end Behavioral;
