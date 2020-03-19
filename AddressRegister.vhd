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
-- File: AddressRegister.vhd
--
-- Description:
-- The address register for the NanoCore processor.  This register holds the
-- memory address that is being accessed.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AddressRegister is
	port (Clock : in std_logic;
	AddressSelection : in std_logic_vector(2 downto 0);
	DirectPageAddressBus, DataBus, AddressLowByteIn : in std_logic_vector(7 downto 0);
	ProgramCounterBusIn : in std_logic_vector(15 downto 0);
	AddressOut : out std_logic_vector(15 downto 0));
end AddressRegister;

architecture Behavioral of AddressRegister is
begin
	AddressRegisterOperation : process (Clock) is
		variable addressRegister : std_logic_vector(15 downto 0) := (others => '0');
	begin
		if Clock'event and Clock = '1' then
		--0 - Do nothing.
		--1 - Load address from program counter.
		--2 - Load high byte of address from direct page register and the low byte
		--    of the address from the data bus.
		--3 - Load address for program counter most significant byte temporary
		--    memory.
		--4 - Load address for program counter least significant byte temporary
		--    memory.
		--5 - Load address for accumulator temporary memory.
			if unsigned(addressSelection) /= 0 then
				if unsigned(AddressSelection) = 1 then
					addressRegister := ProgramCounterBusIn;
				elsif unsigned(AddressSelection) = 2 then
					addressRegister(7 downto 0) := DataBus;
					addressRegister(15 downto 8) := DirectPageAddressBus;
				elsif unsigned(AddressSelection) = 3 then
					addressRegister := "1111111111111110";
				elsif unsigned(AddressSelection) = 4 then
					addressRegister := "1111111111111111";
				elsif unsigned(AddressSelection) = 5 then
					addressRegister := "1111111111111101";
				else
					addressRegister(7 downto 0) := AddressLowByteIn;
					addressRegister(15 downto 8) := DataBus;
				end if;
			end if;
		end if;
		
		--Put the output of the register onto the internal bus.
		AddressOut <= addressRegister;
	end process AddressRegisterOperation;
end Behavioral;
