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
-- File: DirectPageRegister.vhd
--
-- Description:
-- The direct page register for the NanoCore processor.  This register holds the
-- most significant byte of the address used for direct page memory access.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DirectPageRegister is
	port (Clock : in std_logic;
	DirectPageSelection : in std_logic_vector(1 downto 0);
	DataBusIn : in std_logic_vector(7 downto 0);
	DirectPageAddressOut : out std_logic_vector(7 downto 0));
end DirectPageRegister;

architecture Behavioral of DirectPageRegister is
begin
	DirectPageOperation : process (Clock) is
		variable directPageRegister : std_logic_vector(7 downto 0) := (others => '1');
	begin
		if Clock'event and Clock = '1' then
			--0 - Do nothing.
			--1 - Load value from data bus.
			--2 - Increment the register.
			--3 - Decrement the register.
			if unsigned(DirectPageSelection) = 1 then
				directPageRegister(7 downto 0) := DataBusIn;
			elsif unsigned(DirectPageSelection) = 2 then
				directPageRegister := std_logic_vector(unsigned(directPageRegister) + 1);
			elsif unsigned(DirectPageSelection) = 3 then
				directPageRegister := std_logic_vector(unsigned(directPageRegister) - 1);
			else
				directPageRegister := directPageRegister;
			end if;
		end if;
		
		--Put the output of the register onto the internal bus.
		DirectPageAddressOut <= directPageRegister;
	end process DirectPageOperation;
end Behavioral;
