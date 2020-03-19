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
-- File: AddressLowByteRegister.vhd
--
-- Description:
-- Temporary holder for the low byte of a address which is coming from
-- instructions such as jumps, branches, and load/store absolutes.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity AddressLowByteRegister is
	port (Clock, AddressLowByteSelection : in std_logic;
	DataBusIn : in std_logic_vector(7 downto 0);
	AddressLowByteOut : out std_logic_vector(7 downto 0));
end AddressLowByteRegister;

architecture Behavioral of AddressLowByteRegister is
begin
	AddressLowByteRegisterOperation : process (Clock) is
		variable addressLowByteRegister : std_logic_vector(7 downto 0) := (others => '0');
	begin
		if Clock'event and Clock = '1' then
			if AddressLowByteSelection = '1' then
				addressLowByteRegister := DataBusIn;
			else
				addressLowByteRegister := addressLowByteRegister;
			end if;
		end if;
		
		--Put the output of the register onto the internal bus.
		AddressLowByteOut <= addressLowByteRegister;
	end process AddressLowByteRegisterOperation;
end Behavioral;
