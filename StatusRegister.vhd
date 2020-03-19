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
-- File: StatusRegister.vhd
--
-- Description:
-- The status register for the NanoCore processor.  The status register holds the
-- carry and zero result of an ALU operation and an accumulator load.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity StatusRegister is
	port (Clock, CarryBorrowIn, LogicCarryIn : in std_logic;
	StatusSelection : in std_logic_vector(2 downto 0);
	SAddSub, SLogic, DataBus : in std_logic_vector(7 downto 0);
	CarryOut, ZeroOut : out std_logic);
end StatusRegister;

architecture Behavioral of StatusRegister is
begin
	StatusOperation : process (Clock) is
		variable carryBorrowRegister : std_logic := '0';
		variable zeroRegister : std_logic := '0';
	begin
		if Clock'event and Clock = '1' then
			--0 - Do nothing.
			--1 - Set zero flag based on value from data bus.
			--2 - Set zero flag based on value from logical operation.
			--3 - Set carry and zero flag from rotate operation.
			--4 - Set carry and zero flag based on value from arithmetic operation.
			--5 - Clear carry flag.
			--6 - Set carry flag.
			if unsigned(StatusSelection) = 1 then
				carryBorrowRegister := carryBorrowRegister;
				if unsigned(DataBus) = 0 then
					zeroRegister := '1';
				else
					zeroRegister := '0';
				end if;
			elsif unsigned(StatusSelection) = 2 then
				carryBorrowRegister := carryBorrowRegister;
				if unsigned(SLogic) = 0 then
					zeroRegister := '1';
				else
					zeroRegister := '0';
				end if;
			elsif unsigned(StatusSelection) = 3 then
				carryBorrowRegister := LogicCarryIn;
				if unsigned(SLogic) = 0 then
					zeroRegister := '1';
				else
					zeroRegister := '0';
				end if;
			elsif unsigned(StatusSelection) = 4 then
				carryBorrowRegister := CarryBorrowIn;
				if unsigned(SAddSub) = 0 then
					zeroRegister := '1';
				else
					zeroRegister := '0';
				end if;
			elsif unsigned(StatusSelection) = 5 then
				carryBorrowRegister := '0';
				zeroRegister := zeroRegister;
			elsif unsigned(StatusSelection) = 6 then
				carryBorrowRegister := '1';
				zeroRegister := zeroRegister;
			else
				carryBorrowRegister := carryBorrowRegister;
				zeroRegister := zeroRegister;
			end if;
		end if;
		
		--Put the output of the status register onto the internal signal.
		CarryOut <= carryBorrowRegister;
		ZeroOut <= zeroRegister;
	end process StatusOperation;
end Behavioral;
