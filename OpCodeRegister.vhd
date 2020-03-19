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
-- File: OpCodeRegister.vhd
--
-- Description:
-- The op code register for the NanoCore processor.  The op code register is used
-- to hold the current op code being executed.  This register is only loaded when
-- cycle is 1.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OpCodeRegister is
	port (Clock, ResetSignal : in std_logic;
	CycleBusIn : in std_logic_vector(2 downto 0);
	DataBusIn : in std_logic_vector(4 downto 0);
	OpCodeBusOut : out std_logic_vector(4 downto 0));
end OpCodeRegister;

architecture Behavioral of OpCodeRegister is
begin
	OpCodeRegisterOperation : process (Clock) is
		variable opCodeRegister : std_logic_vector(4 downto 0) := "10110";
	begin
		if Clock'event and Clock = '1' then
			if ResetSignal = '0' then
				opCodeRegister := "10110";
			elsif unsigned(CycleBusIn) = 0 then
				opCodeRegister := DataBusIn;
			else
				opCodeRegister := opCodeRegister;
			end if;
		end if;
		
		--Put the output of the op code register onto the op code bus.
		OpCodeBusOut <= opCodeRegister;
	end process OpCodeRegisterOperation;
end Behavioral;
