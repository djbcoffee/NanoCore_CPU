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
-- File: LogicBlock.vhd
--
-- Description:
-- The logic block for the NanoCore processor ALU.  The logic block takes in two
-- 8-bit numbers on the A and B ports (one 8-bit number for rotations) and
-- performs bit wise logic operations on them.  The result is output through the
-- S out port.  The selection input determines which logic operation is done:
-- 3 = Rotate left
--	4 = AND
--	5 = OR
--	6 = XOR
--	7 = Rotate right
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LogicBlock is
	port (StatusIn : in std_logic;
	RotateOut : out std_logic;
	AluSelection : in std_logic_vector(2 downto 0);
	A, B : in std_logic_vector(7 downto 0);
	S : out std_logic_vector(7 downto 0));
end LogicBlock;

architecture Behavioral of LogicBlock is
begin
	LogicOperation : process (StatusIn, AluSelection, A, B) is
		variable sout : std_logic_vector(7 downto 0);
		variable rotatedOutBit : std_logic;
	begin
		--Calculate bit 0 based on the selection.
		if unsigned(AluSelection) = 4 and A(0) = '1' and B(0) = '1' then
			sout(0) := '1';
		elsif unsigned(AluSelection) = 5 and A(0) = '1' and B(0) = '0' then
			sout(0) := '1';
		elsif unsigned(AluSelection) = 5 and A(0) = '0' and B(0) = '1' then
			sout(0) := '1';
		elsif unsigned(AluSelection) = 5 and A(0) = '1' and B(0) = '1' then
			sout(0) := '1';
		elsif unsigned(AluSelection) = 6 and A(0) = '1' and B(0) = '0' then
			sout(0) := '1';
		elsif unsigned(AluSelection) = 6 and A(0) = '0' and B(0) = '1' then
			sout(0) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(0) := StatusIn;
		elsif unsigned(AluSelection) = 7 then
			sout(0) := A(1);
		else
			sout(0) := '0';
		end if;
		
		--Calculate bit 1 based on the selection.
		if unsigned(AluSelection) = 4 and A(1) = '1' and B(1) = '1' then
			sout(1) := '1';
		elsif unsigned(AluSelection) = 5 and A(1) = '1' and B(1) = '0' then
			sout(1) := '1';
		elsif unsigned(AluSelection) = 5 and A(1) = '0' and B(1) = '1' then
			sout(1) := '1';
		elsif unsigned(AluSelection) = 5 and A(1) = '1' and B(1) = '1' then
			sout(1) := '1';
		elsif unsigned(AluSelection) = 6 and A(1) = '1' and B(1) = '0' then
			sout(1) := '1';
		elsif unsigned(AluSelection) = 6 and A(1) = '0' and B(1) = '1' then
			sout(1) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(1) := A(0);
		elsif unsigned(AluSelection) = 7 then
			sout(1) := A(2);
		else
			sout(1) := '0';
		end if;

		--Calculate bit 2 based on the selection.
		if unsigned(AluSelection) = 4 and A(2) = '1' and B(2) = '1' then
			sout(2) := '1';
		elsif unsigned(AluSelection) = 5 and A(2) = '1' and B(2) = '0' then
			sout(2) := '1';
		elsif unsigned(AluSelection) = 5 and A(2) = '0' and B(2) = '1' then
			sout(2) := '1';
		elsif unsigned(AluSelection) = 5 and A(2) = '1' and B(2) = '1' then
			sout(2) := '1';
		elsif unsigned(AluSelection) = 6 and A(2) = '1' and B(2) = '0' then
			sout(2) := '1';
		elsif unsigned(AluSelection) = 6 and A(2) = '0' and B(2) = '1' then
			sout(2) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(2) := A(1);
		elsif unsigned(AluSelection) = 7 then
			sout(2) := A(3);
		else
			sout(2) := '0';
		end if;
		
		--Calculate bit 3 based on the selection.
		if unsigned(AluSelection) = 4 and A(3) = '1' and B(3) = '1' then
			sout(3) := '1';
		elsif unsigned(AluSelection) = 5 and A(3) = '1' and B(3) = '0' then
			sout(3) := '1';
		elsif unsigned(AluSelection) = 5 and A(3) = '0' and B(3) = '1' then
			sout(3) := '1';
		elsif unsigned(AluSelection) = 5 and A(3) = '1' and B(3) = '1' then
			sout(3) := '1';
		elsif unsigned(AluSelection) = 6 and A(3) = '1' and B(3) = '0' then
			sout(3) := '1';
		elsif unsigned(AluSelection) = 6 and A(3) = '0' and B(3) = '1' then
			sout(3) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(3) := A(2);
		elsif unsigned(AluSelection) = 7 then
			sout(3) := A(4);
		else
			sout(3) := '0';
		end if;

		--Calculate bit 4 based on the selection.
		if unsigned(AluSelection) = 4 and A(4) = '1' and B(4) = '1' then
			sout(4) := '1';
		elsif unsigned(AluSelection) = 5 and A(4) = '1' and B(4) = '0' then
			sout(4) := '1';
		elsif unsigned(AluSelection) = 5 and A(4) = '0' and B(4) = '1' then
			sout(4) := '1';
		elsif unsigned(AluSelection) = 5 and A(4) = '1' and B(4) = '1' then
			sout(4) := '1';
		elsif unsigned(AluSelection) = 6 and A(4) = '1' and B(4) = '0' then
			sout(4) := '1';
		elsif unsigned(AluSelection) = 6 and A(4) = '0' and B(4) = '1' then
			sout(4) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(4) := A(3);
		elsif unsigned(AluSelection) = 7 then
			sout(4) := A(5);
		else
			sout(4) := '0';
		end if;

		--Calculate bit 5 based on the selection.
		if unsigned(AluSelection) = 4 and A(5) = '1' and B(5) = '1' then
			sout(5) := '1';
		elsif unsigned(AluSelection) = 5 and A(5) = '1' and B(5) = '0' then
			sout(5) := '1';
		elsif unsigned(AluSelection) = 5 and A(5) = '0' and B(5) = '1' then
			sout(5) := '1';
		elsif unsigned(AluSelection) = 5 and A(5) = '1' and B(5) = '1' then
			sout(5) := '1';
		elsif unsigned(AluSelection) = 6 and A(5) = '1' and B(5) = '0' then
			sout(5) := '1';
		elsif unsigned(AluSelection) = 6 and A(5) = '0' and B(5) = '1' then
			sout(5) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(5) := A(4);
		elsif unsigned(AluSelection) = 7 then
			sout(5) := A(6);
		else
			sout(5) := '0';
		end if;

		--Calculate bit 6 based on the selection.
		if unsigned(AluSelection) = 4 and A(6) = '1' and B(6) = '1' then
			sout(6) := '1';
		elsif unsigned(AluSelection) = 5 and A(6) = '1' and B(6) = '0' then
			sout(6) := '1';
		elsif unsigned(AluSelection) = 5 and A(6) = '0' and B(6) = '1' then
			sout(6) := '1';
		elsif unsigned(AluSelection) = 5 and A(6) = '1' and B(6) = '1' then
			sout(6) := '1';
		elsif unsigned(AluSelection) = 6 and A(6) = '1' and B(6) = '0' then
			sout(6) := '1';
		elsif unsigned(AluSelection) = 6 and A(6) = '0' and B(6) = '1' then
			sout(6) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(6) := A(5);
		elsif unsigned(AluSelection) = 7 then
			sout(6) := A(7);
		else
			sout(6) := '0';
		end if;

		--Calculate bit 7 based on the selection.
		if unsigned(AluSelection) = 4 and A(7) = '1' and B(7) = '1' then
			sout(7) := '1';
		elsif unsigned(AluSelection) = 5 and A(7) = '1' and B(7) = '0' then
			sout(7) := '1';
		elsif unsigned(AluSelection) = 5 and A(7) = '0' and B(7) = '1' then
			sout(7) := '1';
		elsif unsigned(AluSelection) = 5 and A(7) = '1' and B(7) = '1' then
			sout(7) := '1';
		elsif unsigned(AluSelection) = 6 and A(7) = '1' and B(7) = '0' then
			sout(7) := '1';
		elsif unsigned(AluSelection) = 6 and A(7) = '0' and B(7) = '1' then
			sout(7) := '1';
		elsif unsigned(AluSelection) = 3 then
			sout(7) := A(6);
		elsif unsigned(AluSelection) = 7 then
			sout(7) := StatusIn;
		else
			sout(7) := '0';
		end if;
		
		--Calculate rotated out bit.
		if unsigned(AluSelection) = 3 then
			rotatedOutBit := A(7);
		elsif unsigned(AluSelection) = 7 then
			rotatedOutBit := A(0);
		else
			rotatedOutBit := '0';
		end if;

		--Put the variables onto the outputs.
		RotateOut <= rotatedOutBit;
		S <= sout;
	end process LogicOperation;
end Behavioral;
