library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity datapath is
port(
	-- Entradas de dados
	clk: in std_logic;
	SW: in std_logic_vector(17 downto 0);
	
	-- Entradas de controle
	R1, R2, E1, E2, E3, E4, E5: in std_logic; -- R2 = E1
	
	-- Saídas de dados
	hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_logic_vector(6 downto 0);
	ledr: out std_logic_vector(15 downto 0);
	
	-- Saídas de status
	end_game, end_time, end_round, end_FPGA: out std_logic
);
end entity;

architecture arc of datapath is
---------------------------SIGNALS-----------------------------------------------------------
--contadores
signal TEMPO, X, LOAD: std_logic_vector(3 downto 0);
--FSM_clock
signal CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: std_logic;
--Logica combinacional
signal RESULT: std_logic_vector(7 downto 0);
--Registradores
signal SEL: std_logic_vector(3 downto 0);
signal USER: std_logic_vector(14 downto 0);
signal Bonus, Bonus_reg: std_logic_vector(3 downto 0);
--ROMs
signal CODE_aux: std_logic_vector(14 downto 0);
signal CODE: std_logic_vector(31 downto 0);
--COMP
signal erro: std_logic_vector(14 downto 0);
signal erro_numerico : std_logic_vector(3 downto 0);
--NOR enables displays
signal E23, E25, E12: std_logic;

--signals implícitos--

--dec termometrico
signal stermoround, stermobonus, andtermo, smuxled: std_logic_vector(15 downto 0);
--decoders HEX 7-0
signal sdecod7, sdec7, sdecod6, sdec6, sdecod5, sdecod4, sdec4, sdecod3, sdecod2, sdec2, sdecod1, sdecod0, sdec0: std_logic_vector(6 downto 0);
signal smuxhex7, smuxhex6, smuxhex5, smuxhex4, smuxhex3, smuxhex2, smuxhex1, smuxhex0: std_logic_vector(6 downto 0);
signal edec2, edec0: std_logic_vector(3 downto 0);
--saida ROMs
signal srom0, srom1, srom2, srom3: std_logic_vector(31 downto 0);
signal srom0a, srom1a, srom2a, srom3a: std_logic_vector(14 downto 0);
--FSM_clock
signal E2orE3: std_logic;

--============================================================--
--                      COMPONENTS                            --
--============================================================--

------------------------CONTADORES------------------------------

component counter_time is 
port(Enable, Reset, CLOCK: in std_logic;
    load     : in std_logic_vector(3 downto 0); -- Valor inicial da contagem
    end_time : out std_logic;                  -- Sinal ativo quando o tempo acaba (Q)
    tempo    : out std_logic_vector(3 downto 0) -- Valor atual do contador (tc)
);
end component;

component counter_round is
port(Enable, Reset, CLOCK: in std_logic;
	 Round: out std_logic_vector(3 downto 0);   -- X
	 end_round: out std_logic                   -- "tc"
	 );
end component;

-------------------DIVISOR DE FREQUENCIA------------------------

component FSM_clock_de2 is
port(reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

component FSM_clock_emu is
port(reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

----------------------DECODIFICADORES-----------------------------

component decoder_termometrico is
 port(X: in  std_logic_vector(3 downto 0);
	  S: out std_logic_vector(15 downto 0)
     );
end component;

component decod7seg is
port(
    C: in std_logic_vector(3 downto 0);
    HEX0: out std_logic_vector(6 downto 0)
    );
end component;

component d_code is
port(C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

---------------------MULTIPLEXADORES----------------------------

component mux_2x1_7bits is
port(sel: in std_logic;                    -- sel
	x, y: in std_logic_vector(6 downto 0); -- E0, E1
	saida: out std_logic_vector(6 downto 0)-- saida
);
end component;

component mux_2x1_16bits is
port(E0, E1: in std_logic_vector(15 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(15 downto 0)
);
end component;

component mux_4x1_1bit is
port(E0, E1, E2, E3: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic
);
end component;

component mux_4x1_15bits is
port(sel: in std_logic_vector(1 downto 0);
    E0, E1, E2, E3: in std_logic_vector(14 downto 0);
    saida: out std_logic_vector(14 downto 0)
);
end component;

component mux_4x1_32bits is
port(sel: in std_logic_vector(1 downto 0);
    E0, E1, E2, E3: in std_logic_vector(31 downto 0);
    saida: out std_logic_vector(31 downto 0)
);
end component;

-------------------ELEMENTOS DE MEMORIA-------------------------

component reg_4bits is 
port(CLK, RST, enable: in std_logic;
    D: in std_logic_vector(3 downto 0);
    Q: out std_logic_vector(3 downto 0)
    );
end component;

component reg_15bits is 
port(CLK, RST, enable: in std_logic;
	D: in std_logic_vector(14 downto 0);
	Q: out std_logic_vector(14 downto 0)
    );
end component;

component ROM0 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM1 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM2 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM3 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM0a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM1a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM2a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM3a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

--component registrador_bonus is 
--port(
--	S, E, clock: in std_logic;
--	D: in std_logic_vector(3 downto 0);
--	Q: out std_logic_vector(3 downto 0) 
--);
--end component;

-------------------COMPARADORES--------------------------

component COMP_n_erros is
port(CODE_aux, USER: in std_logic_vector(14 downto 0); -- E1, E0
	 erros: out std_logic_vector(14 downto 0)          -- diferente
    );
end component;

component COMP_0 is
port(Bonus_reg: in std_logic_vector(3 downto 0); -- E0
	 endgame: out std_logic
    );
end component;

-------------------SOMA E SUBTRAÇÃO--------------------------

component subtracao is
port(E0: in std_logic_vector(3 downto 0);
	E1: in std_logic_vector(3 downto 0);
	resultado: out std_logic_vector(3 downto 0)
);
end component;

--Somador bit a bit
component bit_sum is
port (seq : in  std_logic_vector(14 downto 0);
      soma_out    : out std_logic_vector(3 downto 0));
end component;

-------------------LÓGICA--------------------------

component logica_comb is 
port(X, Bonus_reg: in std_logic_vector(3 downto 0); -- round, bonus
	 Sel: in std_logic_vector(1 downto 0);          -- nivel
	 RESULT: out std_logic_vector(7 downto 0)       -- points
);
end component;


-- COMEÇO DO CODIGO ---------------------------------------------------------------------------------------

begin	

---------------------------FSM_clock--------------------------------------
--freq_de2: FSM_clock_de2 port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz); -- Para usar na placa DE2
freq_emu: FSM_clock_emu port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz); -- Para usar no emulador

--counter_time
CT0: counter_time port map(R1, E3, CLK_1Hz, LOAD, end_time, TEMPO);

--counter_round
CTR0: counter_round port map (E4, R2, CLK_050Hz, X, end_round);

--decoder_termometrico
DECX: decoder_termometrico port map(Bonus_reg, stermobonus);
DECBONUS: decoder_termometrico port map(X, stermoround);

--decod7seg
DEC_HEX7: decod7seg port map();
DEC_HEX6: decod7seg port map();
DEC_HEX4: decod7seg port map();
DEC_HEX2: decod7seg port map();
DEC_HEX0: decod7seg port map();

--d_code
DCODE_HEX7: d_code port map();
DCODE_HEX6: d_code port map();
DCODE_HEX5: d_code port map();
DCODE_HEX4: d_code port map();
DCODE_HEX3: d_code port map();
DCODE_HEX2: d_code port map();
DCODE_HEX1: d_code port map();
DCODE_HEX0: d_code port map();

--mux_2x1_7bits
MUX_HEX7: mux_2x1_7bits port map();
MUX_HEX6: mux_2x1_7bits port map();
MUX_HEX5: mux_2x1_7bits port map();
MUX_HEX4: mux_2x1_7bits port map();
MUX_HEX3: mux_2x1_7bits port map();
MUX_HEX2: mux_2x1_7bits port map();
MUX_HEX1: mux_2x1_7bits port map();
MUX_HEX0: mux_2x1_7bits port map();

--mux_2x1_16bits
andtermo <= stermoround and not(E1);
MUX_LEDR: mux_2x1_16bits port map(stermobonus, andtermo, SW(17), smuxled);

--mux_4x1_1bit
MUX_FSM_CLK: mux_4x1_1bit port map(CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz, SEL(1 downto 0), end_FPGA);

--mux_4x1_15bits
MUX_ROMaux: mux_4x1_15bits port map(SEL(3 downto 2), srom0a, srom1a, srom2a, srom3a, CODE);

--mux_4x1_32bits
MUX_ROM: mux_4x1_32bits port map(SEL(3 downto 2), srom0, srom1, srom2, srom3, CODE_aux);

--reg_4bits
REG_BONUS: reg_4bits port map(CLK_050Hz, R2, E4, Bonus, Bonus_reg);
REG_SEL: reg_4bits port map(CLK_050Hz, R2, E1, SW(3 downto 0), SEL);

--reg_15bits
REG_USER: reg_15bits port map(CLK_050Hz, R2, E3, USER);

--COMP_n_erros
COMP_ERRO: COMP_n_erros port map(CODE_aux, USER, erro);

--COMP_0
COMP_END: COMP_0 port map(Bonus_reg, end_game);

--subtracao
SUB0: subtracao port map(Bonus_reg, erro);

--logica_comb
LOGICA0: logica_comb port map(X, Bonus_reg, SEL(1 downto 0), RESULT);

--ROM0
ROM_0: ROM0 port map(X, srom0);

--ROM0a
ROM_0a: ROM0a port map(X, srom0a);

--ROM1
ROM_1: ROM1 port map(X, srom1);

--ROM1a
ROM_1a: ROM1a port map(X, srom1a);

--ROM2
ROM_2: ROM2 port map(X, srom2);

--ROM2a
ROM_2a: ROM2a port map(X, srom2a);

--ROM3
ROM_3:vROM3 port map(X, srom3);

--ROM3a
ROM_3a: ROM3a port map(X, srom3a);


end arc;
