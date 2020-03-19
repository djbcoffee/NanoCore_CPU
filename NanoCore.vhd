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
-- File: NanoCore.vhd
--
-- Description:
-- The internal structure of the NanoCore processor.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity NanoCore is
	port (Clock, nReset : in std_logic;
	AddressPins : out std_logic_vector(15 downto 0);
	nWE : inout std_logic;
	DataPins : inout std_logic_vector(7 downto 0));
end NanoCore;

architecture Struct of NanoCore is
	signal AddressLowByteSelection : std_logic;
	signal Carry : std_logic;
	signal CarryBorrowOut : std_logic;
	signal DataOutEnable : std_logic;
	signal LogicCarryOut : std_logic;
	signal OpCodeDone : std_logic;
	signal ResetSignal : std_logic;
	signal WriteSelection : std_logic;
	signal Zero : std_logic;
	
	signal DirectPageSelection : std_logic_vector(1 downto 0);
	
	signal AccumulatorSelection : std_logic_vector(2 downto 0);
	signal AddressSelection : std_logic_vector(2 downto 0);
	signal AluSelection : std_logic_vector(2 downto 0);
	signal PcSelection : std_logic_vector(2 downto 0);
	signal StatusSelection : std_logic_vector(2 downto 0);
	
	signal CycleBus : std_logic_vector(2 downto 0);
	
	signal OpCodeBus : std_logic_vector(4 downto 0);
	
	signal AccumulatorBus : std_logic_vector(7 downto 0);
	signal AddressLowByteBus : std_logic_vector(7 downto 0);
	signal DataBus : std_logic_vector(7 downto 0);
	signal DirectPageAddressBus : std_logic_vector(7 downto 0);
	signal SAddSub : std_logic_vector(7 downto 0);
	signal SLogic : std_logic_vector(7 downto 0);
	
	signal ProgramCounterBus : std_logic_vector(15 downto 0);
	
	attribute keep : string;
	attribute keep of AddressLowByteSelection : signal is "TRUE";
	attribute keep of CarryBorrowOut : signal is "TRUE";
	attribute keep of LogicCarryOut : signal is "TRUE";
	attribute keep of SAddSub : signal is "TRUE";
	attribute keep of SLogic : signal is "TRUE";
	attribute keep of WriteSelection : signal is "TRUE";
	attribute keep of AccumulatorSelection : signal is "TRUE";
	attribute keep of AddressSelection : signal is "TRUE";
	attribute keep of AluSelection : signal is "TRUE";
	attribute keep of DirectPageSelection : signal is "TRUE";
	attribute keep of PcSelection : signal is "TRUE";
	attribute keep of StatusSelection : signal is "TRUE";
	attribute keep of OpCodeDone : signal is "TRUE";
begin
	Accumulator : entity work.Accumulator(Behavioral)
		port map (Clock, DataOutEnable, AccumulatorSelection, SAddSub, SLogic, DataBus, ProgramCounterBus, DataBus, AccumulatorBus, DataPins);
	AddressLowByteRegister : entity work.AddressLowByteRegister(Behavioral)
		port map (Clock, AddressLowByteSelection, DataBus, AddressLowByteBus);
	AddressRegister : entity work.AddressRegister(Behavioral)
		port map (Clock, AddressSelection, DirectPageAddressBus, DataBus, AddressLowByteBus, ProgramCounterBus, AddressPins);
	ALU : entity work.ALU(Struct)
		port map (Clock, Carry, AluSelection, AccumulatorBus, DataBus, LogicCarryOut, CarryBorrowOut, SLogic, SAddSub);
	ControlUnit : entity work.ControlUnit(Behavioral)
		port map (Carry, Zero, CycleBus, OpCodeBus, OpCodeDone, WriteSelection, AddressLowByteSelection, DirectPageSelection, AccumulatorSelection, AddressSelection, PcSelection, StatusSelection, AluSelection);
	CycleCounter : entity work.CycleCounter(Behavioral)
		port map (Clock, ResetSignal, OpCodeDone, CycleBus);
	DirectPageRegister : entity work.DirectPageRegister(Behavioral)
		port map (Clock, DirectPageSelection, DataBus, DirectPageAddressBus);
	OpCodeRegister : entity work.OpCodeRegister(Behavioral)
		port map (Clock, ResetSignal, CycleBus, DataBus(4 downto 0), OpCodeBus);
	ProgramCounter : entity work.ProgramCounter(Behavioral)
		port map (Clock, ResetSignal, PcSelection, DataBus, AddressLowByteBus, ProgramCounterBus);
	Reset : entity work.Reset(Behavioral)
		port map (Clock, nReset, ResetSignal);
	StatusRegister : entity work.StatusRegister(Behavioral)
		port map (Clock, CarryBorrowOut, LogicCarryOut, StatusSelection, SAddSub, SLogic, DataBus, Carry, Zero);
	WriteEnableRegister : entity work.WriteEnableRegister(Behavioral)
		port map (Clock, WriteSelection, DataOutEnable, nWE);
end architecture Struct;
