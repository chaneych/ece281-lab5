--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity top_basys3 is
    port(
        -- inputs
        clk     :   in std_logic; -- native 100MHz FPGA clock
        sw      :   in std_logic_vector(7 downto 0); -- operands and opcode
        btnU    :   in std_logic; -- reset
        btnC    :   in std_logic; -- fsm cycle
        btnL    :   in std_logic; -- clock divider reset
        
        -- outputs
        led :   out std_logic_vector(15 downto 0);
        -- 7-segment display segments (active-low cathodes)
        seg :   out std_logic_vector(6 downto 0);
        -- 7-segment display active-low enables (anodes)
        an  :   out std_logic_vector(3 downto 0)
    );
end top_basys3;

architecture top_basys3_arch of top_basys3 is 
  
	-- declare components and signals
	component controller_fsm is
	   port (  clk     : in STD_LOGIC;
	          i_reset : in STD_LOGIC;
	           i_adv   : in STD_LOGIC;
	           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component ALU is
	   port (  i_A      : in STD_LOGIC_VECTOR (7 downto 0);
	           i_B      : in STD_LOGIC_VECTOR (7 downto 0);
	           i_op     : in STD_LOGIC_VECTOR (2 downto 0);
	           o_result : out STD_LOGIC_VECTOR (7 downto 0);
	           o_flags  : out STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component clock_divider is
	   generic ( constant k_DIV : natural := 2 );
	   port (  i_clk   : in std_logic;
	           i_reset : in std_logic;
	           o_clk   : out std_logic);
    end component;
    
    component twoscomp_decimal is
        port (  i_bin  : in std_logic_vector(7 downto 0);
                o_sign : out std_logic;
                o_hund : out std_logic_vector(3 downto 0);
                o_tens : out std_logic_vector(3 downto 0);
                o_ones : out std_logic_vector(3 downto 0));
    end component;

    component TDM4 is
        generic (constant k_WIDTH : natural := 4);
        port (  i_clk   : in STD_LOGIC;
                i_reset : in STD_LOGIC;
                i_D3    : in STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
                i_D2    : in STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
                i_D1    : in STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
                i_D0    : in STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
                o_data  : out STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
                o_sel   : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component sevenseg_decoder is
        port (  i_Hex   : in STD_LOGIC_VECTOR (3 downto 0);
                o_seg_n : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
begin
	-- PORT MAPS ----------------------------------------

	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	
	
end top_basys3_arch;
