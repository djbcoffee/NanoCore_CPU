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
-- File: CarryRegister.vhd
--
-- Description:
-- The carry in register for the NanoCore processor ALU.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CarryRegister is
	port (Clock, CarryIn : in std_logic;
	AluSelection : in std_logic_vector(2 downto 0);
	CarryStatusOut : out std_logic);
end CarryRegister;

architecture Behavioral of CarryRegister is
begin
	CarryRegisterLoad : process (Clock) is
		variable carryRegister : std_logic := '0';
	begin
		if Clock'event and Clock = '1' then
			--Load the register with the proper value based on the operation.
			--0 - Do nothing.
			--1 - Do addition, not needed so load with 0.
			--2 - Do subtraction, load with 1 to perform 2's compliment subtraction.
			--3 - Do rotate left, load with the current value of carry from the
			--    status register.
			--4 - Do logical AND, not needed so load with 0.
			--5 - Do logical OR, not needed so load with 0.
			--6 - Do logical XOR, not needed so load with 0.
			--7 - Do rotate right, load with the current value of carry from the
			--    status register.
			if unsigned(AluSelection) /= 0 then
				if unsigned(AluSelection) = 1 then
					carryRegister := '0';
				elsif unsigned(AluSelection) = 2 then
					carryRegister := '1';
				elsif unsigned(AluSelection) = 3 then
					carryRegister := CarryIn;
				elsif unsigned(AluSelection) = 4 then
					carryRegister := '0';
				elsif unsigned(AluSelection) = 5 then
					carryRegister := '0';
				elsif unsigned(AluSelection) = 6 then
					carryRegister := '0';
				else
					carryRegister := CarryIn;
				end if;
			end if;
		end if;
		
		--Put the value on the internal signal.
		CarryStatusOut <= carryRegister;
	end process CarryRegisterLoad;
end architecture Behavioral;
