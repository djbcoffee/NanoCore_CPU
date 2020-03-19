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
-- File: WriteEnableRegister.vhd
--
-- Description:
-- The write enable register for the NanoCore processor.  Controls the nWE signal
-- for the external bus.  The signal is also routed unto one of the global
-- tristate lines to control the output enable of the data pins so that when the
-- output nWE line is low the output drivers in the Accumulator module are put
-- into output mode.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
Library unisim;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use unisim.vcomponents.all;

entity WriteEnableRegister is
	port (Clock, WriteSelection : in std_logic;
	DataOutEnable : out std_logic;
	nWE : inout std_logic);
end entity WriteEnableRegister;

architecture Behavioral of WriteEnableRegister is
	signal WriteEnableSignal : std_logic := '1';
begin
	--Uses primitives for the output buffer and global tristate buffer that are
	--specific to the XC9500XL series CPLD.
	WriteEnableObuf : OBUF
		generic map (SLEW => "FAST")
		port map (O => nWE, I => WriteEnableSignal);
	
	WriteEnableBufgts : BUFGTS
		port map (O => DataOutEnable, I => nWE);

	WriteEnableRegisterOperation : process (Clock) is
	begin
		if Clock'event and Clock = '1' then
			if WriteSelection = '1' then
				WriteEnableSignal <= '0';
			else
				WriteEnableSignal <= '1';
			end if;
		end if;
	end process WriteEnableRegisterOperation;
end architecture Behavioral;
