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
-- File: Accumulator.vhd
--
-- Description:
-- The accumulator for the NanoCore processor.  The accumulator is used in each
-- ALU operation and is the source of the ALU out.  The accumulator is also used
-- to move data to and from memory.  For this reason, and the internal structure
-- of the CPLD, it serves as the output for the CPU.  Since the output drivers
-- for the data pins are part of this module the input drivers are also included.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
library unisim;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use unisim.vcomponents.all;

entity Accumulator is
	port (Clock, DataOutEnable : in std_logic;
	AccumulatorSelection : in std_logic_vector(2 downto 0);
	SAddSub, SLogic, DataBusIn : in std_logic_vector(7 downto 0);
	ProgramCounterBusIn : in std_logic_vector(15 downto 0);
	DataBusOut : out std_logic_vector(7 downto 0);
	AccumulatorBus, DataPins : inout std_logic_vector(7 downto 0));
end Accumulator;

architecture Behavioral of Accumulator is
begin
	--Uses primitives for the output and input buffers that are specific to the
	--XC9500XL series CPLD.  The output buffer uses the active low enable.
	AccumulatorOutBufferBit0 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(0), I => AccumulatorBus(0), T => DataOutEnable);
	AccumulatorOutBufferBit1 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(1), I => AccumulatorBus(1), T => DataOutEnable);
	AccumulatorOutBufferBit2 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(2), I => AccumulatorBus(2), T => DataOutEnable);
	AccumulatorOutBufferBit3 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(3), I => AccumulatorBus(3), T => DataOutEnable);
	AccumulatorOutBufferBit4 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(4), I => AccumulatorBus(4), T => DataOutEnable);
	AccumulatorOutBufferBit5 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(5), I => AccumulatorBus(5), T => DataOutEnable);
	AccumulatorOutBufferBit6 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(6), I => AccumulatorBus(6), T => DataOutEnable);
	AccumulatorOutBufferBit7 : OBUFT
		generic map (SLEW => "FAST")
		port map (O => DataPins(7), I => AccumulatorBus(7), T => DataOutEnable);
		
	DataBusInBufferBit0 : IBUF
		port map (O => DataBusOut(0), I => DataPins(0));
	DataBusInBufferBit1 : IBUF
		port map (O => DataBusOut(1), I => DataPins(1));
	DataBusInBufferBit2 : IBUF
		port map (O => DataBusOut(2), I => DataPins(2));
	DataBusInBufferBit3 : IBUF
		port map (O => DataBusOut(3), I => DataPins(3));
	DataBusInBufferBit4 : IBUF
		port map (O => DataBusOut(4), I => DataPins(4));
	DataBusInBufferBit5 : IBUF
		port map (O => DataBusOut(5), I => DataPins(5));
	DataBusInBufferBit6 : IBUF
		port map (O => DataBusOut(6), I => DataPins(6));
	DataBusInBufferBit7 : IBUF
		port map (O => DataBusOut(7), I => DataPins(7));

	AccumulatorOperation : process (Clock) is
		variable accumulatorRegister : std_logic_vector(7 downto 0) := (others => '0');
	begin
		if Clock'event and Clock = '1' then
			--0 - Do nothing.
			--1 - Load accumulator from the data bus.
			--2 - Load accumulator from the logic block output.
			--3 - Load accumulator from the add/sub block.
			--4 - Load the least significant byte of the program counter into the
			--    accumulator.  This is used to output the program counter into
			--    memory during a sub-routine call.  The only data output is
			--    through the accumulator.
			--5 - Load the most significant byte of the program counter into the
			--    accumulator.  This is used to output the program counter into
			--    memory during a sub-routine call.  The only data output is
			--    through the accumulator.
			if unsigned(AccumulatorSelection) /= 0 then
				if unsigned(AccumulatorSelection) = 1 then
					accumulatorRegister := DataBusIn;
				elsif unsigned(AccumulatorSelection) = 2 then
					accumulatorRegister := SLogic;
				elsif unsigned(AccumulatorSelection) = 3 then
					accumulatorRegister := SAddSub;
				elsif unsigned(AccumulatorSelection) = 4 then
					accumulatorRegister := ProgramCounterBusIn(7 downto 0);
				else
					accumulatorRegister := ProgramCounterBusIn(15 downto 8);
				end if;
			end if;
		end if;
		
		--Put the output of the accumulator register onto the accumulator bus.
		--The accumulator bus feeds back into the CPU and also connects to the
		--in of the output buffers.
		AccumulatorBus <= accumulatorRegister;
	end process AccumulatorOperation;
end Behavioral;
