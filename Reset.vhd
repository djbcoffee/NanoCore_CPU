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
-- File: Reset.vhd
--
-- Description:
-- Syncronizer for the reset signal.
---------------------------------------------------------------------------------
-- DJB 06/01/14 Created.
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Reset is
	port
	(
		Clock, nReset : in std_logic;
		ResetSignal : out std_logic
	);
end entity Reset;

architecture Behavioral of Reset is
begin
	ResetSync : process (Clock) is
		variable resetSync : std_logic_vector(1 downto 0) := (others => '0');
	begin
		-- Check for activity on every rising edge of the system clock.
		if Clock'event and Clock = '1' then
			-- A two-stage register that is used to synchronize a chip reset.  The
			-- first register in the stage connects directly to the nReset pin.
			-- This register will take any metastability issues that may occur from
			-- the async pin changing in relation to the system clock.  The second
			-- register is used to generate the reset signal from the output of the
			-- first register.  The second third register is protected from
			-- metastability and its output can be reliably used as a synchronous
			-- signal.  All together the two registers are connected in a shift
			-- configuration.
			resetSync(1) := resetSync(0);
			resetSync(0) := nReset;
		end if;
		
		-- Reset signal used by other modules.
		ResetSignal <= resetSync(1);
	end process ResetSync;
end architecture Behavioral;

