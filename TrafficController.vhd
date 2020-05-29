library IEEE;
library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
--USE IEEE.numeric_std.ALL;


entity TrafficController is
port (  
clk: in std_logic;
AW_switch: in std_logic;  -- przelacznik stanu awaryjnego 					
sygnalizator: out STD_LOGIC_VECTOR (5 downto 0);
timer: out STD_LOGIC_VECTOR(13 downto 0)
);
end TrafficController;

architecture serce of TrafficController is
type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
type tliczba_type is (t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11);
SIGNAL state: state_type:=s0;
SIGNAL tliczba: tliczba_type:=t10;
SIGNAL count: STD_LOGIC_VECTOR(3 downto 0):="0000";
SIGNAL liczsek : STD_LOGIC_VECTOR(25 DOWNTO 0):="00000000000000000000000000";  -- sekundnik 



																									
constant czas_zolte:integer:=3;   --3 sekundy trwania swiatla zoltego
constant czas_inne:integer:=10;   --10 sekund trwania innych swiatel ( zielony/czerwony)
constant czas_awaria:integer:=2;  -- Miganie 2 sekundy



begin


	Glowny:
	process(clk,AW_switch)
		begin 
				

				if rising_edge(clk) then   
				
				IF (liczsek = "10111110101111000001111111") THEN  	-- Zerowanie gdy licznik dochodzi do 49 999 999 [Zalozenie ze zegar ma 50 MHz]
				liczsek <= "00000000000000000000000000";
				count <= count + '1'; 										-- Zwiekszanie count o 1 gdy sekundnik sie przekreca.
				ELSE
				liczsek <= liczsek + '1';
				END IF;
				
				case state is
	              

				when s0 =>
												
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
				elsif count <czas_inne then
				            state <= s0;
								
					    								
						 if count = "0000" then
						 tliczba<=t10;
						 end if;
						 if count = "0001" then
						 tliczba<=t9;
						 end if;
						 if count = "0010" then
						 tliczba<=t8;
						 end if;
						 if count = "0011" then
						 tliczba<=t7;
						 end if;
						 if count = "0100" then
						 tliczba<=t6;
						 end if;
						 if count = "0101" then
						 tliczba<=t5;
						 end if;
						 if count = "0110" then
						 tliczba<=t4;
						 end if;
						 if count = "0111" then
						 tliczba<=t3;
						 end if;
						 if count = "1000" then
						 tliczba<=t2;
						 end if;
						 if count = "1001" then
						 tliczba<=t1;
						 end if;
						 if count = "1010" then
						 tliczba<=t0;
						 end if;
					
					else
					 state <= s1;
					 tliczba<=t11;
					 count <= "0000";   
					end if;
					
			

                                    when s1 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
			            elsif count < czas_zolte then
						 state <= s1;
						 
						 
					 else
						 state <= s2;
						 count <= "0000";
					 end if;
					 
                                    when s2 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
				elsif count <czas_zolte then
				            state <= s2;
					    
					else
					 state <= s3;
					 count <= "0000";
					end if;
					
			

                                    when s3 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
			            elsif count < czas_zolte then
						 state <= s3;
						 
					 else
						 state <= s4;
						 count <= "0000";
					 
					end if;

                                     when s4 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
				elsif count <czas_inne then
				            state <= s4;
					   
						 if count = "0000" then
						 tliczba<=t10;
						 end if;
						 if count = "0001" then
						 tliczba<=t9;
						 end if;
						 if count = "0010" then
						 tliczba<=t8;
						 end if;
						 if count = "0011" then
						 tliczba<=t7;
						 end if;
						 if count = "0100" then
						 tliczba<=t6;
						 end if;
						 if count = "0101" then
						 tliczba<=t5;
						 end if;
						 if count = "0110" then
						 tliczba<=t4;
						 end if;
						 if count = "0111" then
						 tliczba<=t3;
						 end if;
						 if count = "1000" then
						 tliczba<=t2;
						 end if;
						 if count = "1001" then
						 tliczba<=t1;
						 end if;
						 if count = "1010" then
						 tliczba<=t0;
						 end if;
					else
					 state <= s5;
					 tliczba<=t11;
					 count <= "0000";
					end if;
					
			

                                    when s5 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
			            elsif count < czas_zolte then
						 state <= s5;
						 
					 else
						 state <= s6;
						 count <= "0000";
					 end if;
					
                                    when s6 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
			            elsif count < czas_zolte then
						 state <= s6;
						
					 else
						 state <= s7;
						 count <= "0000";
					 end if;
					
                                    when s7 =>
				if (AW_switch='1') then
				state<=s8;
				count<="0000";
				tliczba<=t11;
			            elsif count < czas_zolte then
						 state <= s7;
						
					 else
						 state <= s0;
						 count <= "0000";
					 end if;
					
				    
				      when s8 =>
				if (AW_switch='0') then
				state<=s0;
				count<="0000";
				tliczba<=t10;
			            elsif count < czas_awaria then
						 state <= s8;
						
					 else
						 state <= s9;
						 count <= "0000";
					 end if;
					
				    when s9 =>
				if (AW_switch='0') then
				state<=s0;
				count<="0000";
				tliczba<=t10;
			            elsif count < czas_awaria then
						 state <= s9;
						 
					 else
						 state <= s8;
						 count <= "0000";
					end if;
					
                                     
				   
			            
                                    when others =>
                                    state <= s0;
			end case;
		
	 end if;
	
				   
end process;

przypisanieSwiatel: 
	process(state)
		begin
			case state is
				when s0=> sygnalizator <= "100001";      -- czerwone - zielone
				when s1=> sygnalizator <= "100010";      -- czerwone - zolte
				when s2=> sygnalizator <= "100100";      -- czerwone - czerwone
				when s3=> sygnalizator <= "110100";      -- czerwone/zolte    - czerwone
				when s4=> sygnalizator <= "001100";      -- zielone  - czerwone
				when s5=> sygnalizator <= "010100";      -- zolte    - czerwone
				when s6=> sygnalizator <= "100100";      -- czerwone - czerwone/zolte
				when s7=> sygnalizator <= "100110";      -- czerwone - zolte
				when s8=> sygnalizator <= "010010";      -- zolte    - zolte
				when s9=> sygnalizator <= "000000";      -- nic      - nic
				when others => sygnalizator <= "100001"; -- czerwone - zielone 
		end case;

	end process;
PrzypisywanieTimer:
	process(tliczba)
		begin
			case tliczba is
			--							  gfedcbagfedcba			
				when t0=> timer <= "00000000111111"; -- 0
				when t1=> timer <= "00000000000110"; -- 1
				when t2=> timer <= "00000001011011"; -- 2
				when t3=> timer <= "00000001001111"; -- 3
				when t4=> timer <= "00000001100110"; -- 4
				when t5=> timer <= "00000001101101"; -- 5
				when t6=> timer <= "00000001111101"; -- 6
				when t7=> timer <= "00000000000111"; -- 7
				when t8=> timer <= "00000001111111"; -- 8
				when t9=> timer <= "00000001101111"; -- 9
			  when t10=> timer <= "00001100111111"; -- 10
			  when t11=> timer <= "00000000000000"; -- wygaszenie
		 when others => timer <= "00000000000000"; -- wygaszenie
			end case;

	end process;

end serce;
