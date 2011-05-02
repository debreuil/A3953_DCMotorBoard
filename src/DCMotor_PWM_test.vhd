--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:09:33 05/01/2011
-- Design Name:   
-- Module Name:   C:/edev/papilio/xpapilio/A3953/DCMotor_PWM_test.vhd
-- Project Name:  A3953
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DCMotor_PWM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DCMotor_PWM_test IS
END DCMotor_PWM_test;
 
ARCHITECTURE behavior OF DCMotor_PWM_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DCMotor_PWM
    PORT(
         CLK : IN  std_logic;
         MODE : OUT  std_logic;
         PHASE : OUT  std_logic;
         ENABLE : OUT  std_logic;
         BRAKE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';

 	--Outputs
   signal MODE : std_logic;
   signal PHASE : std_logic;
   signal ENABLE : std_logic;
   signal BRAKE : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DCMotor_PWM PORT MAP (
          CLK => CLK,
          MODE => MODE,
          PHASE => PHASE,
          ENABLE => ENABLE,
          BRAKE => BRAKE
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
