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
-- File: ABRegisters.vhd
--
-- Description:
-- The two input registers that feed the NanoCore processor ALU.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ABRegisters is
	port (Clock : in std_logic;
	AluSelection : in std_logic_vector(2 downto 0);
	AccumulatorIn, DataBusIn : in std_logic_vector(7 downto 0);
	A, B : out std_logic_vector(7 downto 0));
end ABRegisters;

architecture Behavioral of ABRegisters is
begin
	ABRegisterLoad : process (Clock) is
		variable aRegister : std_logic_vector(7 downto 0) := (others => '0');
		variable bRegister : std_logic_vector(7 downto 0) := (others => '0');
	begin
		if Clock'event and Clock = '1' then
			--Load the registers with the proper values based on the operation.
			--0 - Do nothing.
			--1 - Do addition (A + N).
			--2 - Do subtraction (A - N).
			--3 - Do rotate left (A << 1).
			--4 - Do logical AND (A and N).
			--5 - Do logical OR (A or N).
			--6 - Do logical XOR (A xor N).
			--7 - Do rotate right (A >> 1).
			if unsigned(AluSelection) /= 0 then
				if unsigned(AluSelection) = 1 then
					aRegister := AccumulatorIn;
					bRegister := DataBusIn;
				elsif unsigned(AluSelection) = 2 then
					aRegister := AccumulatorIn;
					bRegister := not DataBusIn;
				elsif unsigned(AluSelection) = 3 then
					aRegister := AccumulatorIn;
					bRegister := bRegister;
				elsif unsigned(AluSelection) = 4 then
					aRegister := AccumulatorIn;
					bRegister := DataBusIn;
				elsif unsigned(AluSelection) = 5 then
					aRegister := AccumulatorIn;
					bRegister := DataBusIn;
				elsif unsigned(AluSelection) = 6 then
					aRegister := AccumulatorIn;
					bRegister := DataBusIn;
				else
					aRegister := AccumulatorIn;
					bRegister := bRegister;
				end if;
			end if;
		end if;
		
		--Push the values in the registers onto the A and B buses of the logic and
		--add/sub blocks.
		A <= aRegister;
		B <= bRegister;
	end process ABRegisterLoad;
end architecture Behavioral;
