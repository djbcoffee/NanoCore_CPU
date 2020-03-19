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
-- File: TwoBitLookAheadAdd.vhd
--
-- Description:
-- A two bit look ahead adder for the NanoCore processor ALU.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity TwoBitLookAheadAdd is
	port (C0 : in std_logic;
	A, B : in std_logic_vector(1 downto 0);
	C2 : out std_logic;
	S : out std_logic_vector(1 downto 0));
end entity TwoBitLookAheadAdd;

architecture Behavioral of TwoBitLookAheadAdd is
begin
	Add : process (A, B, C0) is
		variable sum0 : std_logic;
		variable sum1 : std_logic;
		variable carry1 : std_logic;
		variable carry2 : std_logic;
	begin
		--Calculate sum bit 0.
		if A(0) = '1' and B(0) = '0' and C0 = '0' then
			sum0 := '1';
		elsif A(0) = '0' and B(0) = '1' and C0 = '0' then
			sum0 := '1';
		elsif A(0) = '0' and B(0) = '0' and C0 = '1' then
			sum0 := '1';
		elsif A(0) = '1' and B(0) = '1' and C0 = '1' then
			sum0 := '1';
		else
			sum0 := '0';
		end if;

		--Calculate internal carry from bit 0 to bit 1.
		if A(0) = '1' and B(0) = '1' and C0 = '0' then
			carry1 := '1';
		elsif A(0) = '1' and B(0) = '0' and C0 = '1' then
			carry1 := '1';
		elsif A(0) = '0' and B(0) = '1' and C0 = '1' then
			carry1 := '1';
		elsif A(0) = '1' and B(0) = '1' and C0 = '1' then
			carry1 := '1';
		else
			carry1 := '0';
		end if;

		--Calculate sum bit 1.
		if A(1) = '1' and B(1) = '0' and carry1 = '0' then
			sum1 := '1';
		elsif A(1) = '0' and B(1) = '1' and carry1 = '0' then
			sum1 := '1';
		elsif A(1) = '0' and B(1) = '0' and carry1 = '1' then
			sum1 := '1';
		elsif A(1) = '1' and B(1) = '1' and carry1 = '1' then
			sum1 := '1';
		else
			sum1 := '0';
		end if;

		--Calculate external carry from bit 1.
		if A(1) = '1' and B(1) = '1' and carry1 = '0' then
			carry2 := '1';
		elsif A(1) = '1' and B(1) = '0' and carry1 = '1' then
			carry2 := '1';
		elsif A(1) = '0' and B(1) = '1' and carry1 = '1' then
			carry2 := '1';
		elsif A(1) = '1' and B(1) = '1' and carry1 = '1' then
			carry2 := '1';
		else
			carry2 := '0';
		end if;

		--Put the variables onto the outputs.
		S(0) <= sum0;
		s(1) <= sum1;
		C2 <= carry2;
	end process Add;
end architecture Behavioral;
