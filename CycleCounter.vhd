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
-- File: CycleCounter.vhd
--
-- Description:
-- The cycle counter for the NanoCore processor.  The cycle counter is used to
-- keep track of the state of the processor.  It is reset either by an external
-- signal or when the current opcode is complete.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CycleCounter is
	port (Clock, ResetSignal, OpCodeDone : in std_logic;
	CycleBusOut : out std_logic_vector(2 downto 0));
end CycleCounter;

architecture Behavioral of CycleCounter is
begin
	CycleCounterOperation : process (Clock) is
		variable cycleCounterRegister : std_logic_vector(2 downto 0) := "011";
	begin
		if Clock'event and Clock = '1' then
			if ResetSignal = '0' then
				cycleCounterRegister := "011";
			elsif OpCodeDone = '1' then
				cycleCounterRegister := (others => '0');
			else
				cycleCounterRegister := std_logic_vector(unsigned(cycleCounterRegister) + 1);
			end if;
		end if;
		
		--Put the output of the cycle counter register onto the cycle counter bus.
		CycleBusOut <= cycleCounterRegister;
	end process CycleCounterOperation;
end Behavioral;
