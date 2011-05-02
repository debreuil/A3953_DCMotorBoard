	library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DCMotor_PWM is
	port(
		CLK: in std_logic;
		MODE: out std_logic;
		PHASE: out std_logic;
		ENABLE: out  std_logic;
		BRAKE: out std_logic
	);
end DCMotor_PWM;

architecture behavioral of DCMotor_PWM is

	signal CUR_PHASE : STD_LOGIC := '1';
	signal CUR_PWM : STD_LOGIC := '1';
	constant delay:integer := 32000000 / 500; -- 32000000 CLK/second ... 64000 Hz
	
	constant phaseChange:integer := 900;
	constant minDutyCycle:integer := 10000;
	constant maxDutyCycle:integer := 50000;
	constant pwmStep:integer := (maxDutyCycle - minDutyCycle) / phaseChange;

begin
	
	motorCount: process(CLK)	
	
		variable counter : integer range 0 to delay := 0;
		variable pwm_cut : integer range 0 to delay := 0;		
		variable pwm_dir : STD_LOGIC := '1';	
		
		variable cycle : integer range 0 to 1000 := 0;	
	begin
	
		if CLK'event and CLK = '1' then
		
			if counter > pwm_cut then
				CUR_PWM <= '1';
			else		
				CUR_PWM <= '0';			
			end if;	
		
			if counter = delay then
				
				if cycle >= phaseChange then
					cycle := 0;				
					if pwm_dir = '1' then		
						pwm_dir := '0';
						pwm_cut := maxDutyCycle;
					else			
						pwm_dir := '1';
						pwm_cut := minDutyCycle;
						CUR_PHASE <= not CUR_PHASE;	
					end if;
				else
					cycle := cycle + 1;
					if pwm_dir = '1' then			
						pwm_cut := pwm_cut + pwmStep;
					else	
						pwm_cut := pwm_cut - pwmStep;
					end if;
				end if;
				
				counter := 0;	
				
			else					
				counter := counter + 1;
			end if;	
			
		end if;
		
	end process;
	
	PHASE <= CUR_PHASE;
	ENABLE <= CUR_PWM;
	BRAKE <= '1';
	MODE <= '0';

end behavioral;
