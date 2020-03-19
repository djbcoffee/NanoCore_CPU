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
-- File: AluAdd.vhd
--
-- Description:
-- The internal structure of the NanoCore processor ALU add unit.  The add block
-- takes in two 8-bit numbers on the A and B ports and performs addition on them.
-- The result is output through the S out port.  Uses 4 two-bit look ahead adder
-- circuits.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity AluAdd is
	port (C0 : in std_logic;
	C8 : out std_logic;
	A, B : in std_logic_vector(7 downto 0);
	S : out std_logic_vector(7 downto 0));
end AluAdd;

architecture Struct of AluAdd is
	signal C2 : std_logic;
	signal C4 : std_logic;
	signal C6 : std_logic;
	
	--C2 is the carry bit from the addition of bits 0 and 1.
	--C4 is the carry bit from the addition of bits 2 and 3.
	--C6 is the carry bit from the addition of bits 4 and 5.
	attribute keep : string;
	attribute keep of C2 : signal is "TRUE";
	attribute keep of C4 : signal is "TRUE";
	attribute keep of C6 : signal is "TRUE";
begin
	Bits0And1 : entity work.TwoBitLookAheadAdd(Behavioral)
		port map (C0, A(1 downto 0), B(1 downto 0), C2, S(1 downto 0));
	Bits2And3 : entity work.TwoBitLookAheadAdd(Behavioral)
		port map (C2, A(3 downto 2), B(3 downto 2), C4, S(3 downto 2));
	Bits4And5 : entity work.TwoBitLookAheadAdd(Behavioral)
		port map (C4, A(5 downto 4), B(5 downto 4), C6, S(5 downto 4));
	Bits6And7 : entity work.TwoBitLookAheadAdd(Behavioral)
		port map (C6, A(7 downto 6), B(7 downto 6), C8, S(7 downto 6));
end architecture Struct;
