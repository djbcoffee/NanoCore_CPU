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
-- File: AluLogic.vhd
--
-- Description:
-- The internal structure of the NanoCore processor ALU logic.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity AluLogic is
	port (StatusIn : in std_logic;
	RotateOut : out std_logic;
	AluSelection : in std_logic_vector(2 downto 0);
	A, B : in std_logic_vector(7 downto 0);
	S : out std_logic_vector(7 downto 0));
end AluLogic;

architecture Struct of AluLogic is
begin
	LogicBlock : entity work.LogicBlock(Behavioral)
		port map (StatusIn, RotateOut, AluSelection, A, B, S);
end architecture Struct;
