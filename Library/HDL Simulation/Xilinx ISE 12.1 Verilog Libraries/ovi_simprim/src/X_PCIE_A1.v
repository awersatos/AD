// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/stan/X_PCIE_A1.v,v 1.10.20.1 2010/04/01 22:38:53 robh Exp $
///////////////////////////////////////////////////////
//  Copyright (c) 2009 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 11.1i 
//  \  \           Description : PCI Express Secure IP Timing Wrapper
//  /  /                      
// /__/   /\       Filename    : X_PCIE_A1.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Revision:      Date:  Comment
//       1.0:  08/21/08:  Initial version.
//       1.1:  11/24/08:  Updates to include secureip
//       1.2:  01/22/09:  Updates for NCSIM and VCS
//       1.3:  01/29/09:  CR503397 remove NCELAB work arounds
//       1.4:  02/03/10:  525925 add skew and period checks.
//       1.5:  02/12/10:  525925 skew fix for ncsim, aldec, rtl update.
//       1.6:  03/29	10:  555708 remove skew checks
// End Revision
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_PCIE_A1 (
  CFGBUSNUMBER,
  CFGCOMMANDBUSMASTERENABLE,
  CFGCOMMANDINTERRUPTDISABLE,
  CFGCOMMANDIOENABLE,
  CFGCOMMANDMEMENABLE,
  CFGCOMMANDSERREN,
  CFGDEVCONTROLAUXPOWEREN,
  CFGDEVCONTROLCORRERRREPORTINGEN,
  CFGDEVCONTROLENABLERO,
  CFGDEVCONTROLEXTTAGEN,
  CFGDEVCONTROLFATALERRREPORTINGEN,
  CFGDEVCONTROLMAXPAYLOAD,
  CFGDEVCONTROLMAXREADREQ,
  CFGDEVCONTROLNONFATALREPORTINGEN,
  CFGDEVCONTROLNOSNOOPEN,
  CFGDEVCONTROLPHANTOMEN,
  CFGDEVCONTROLURERRREPORTINGEN,
  CFGDEVICENUMBER,
  CFGDEVSTATUSCORRERRDETECTED,
  CFGDEVSTATUSFATALERRDETECTED,
  CFGDEVSTATUSNONFATALERRDETECTED,
  CFGDEVSTATUSURDETECTED,
  CFGDO,
  CFGERRCPLRDYN,
  CFGFUNCTIONNUMBER,
  CFGINTERRUPTDO,
  CFGINTERRUPTMMENABLE,
  CFGINTERRUPTMSIENABLE,
  CFGINTERRUPTRDYN,
  CFGLINKCONTOLRCB,
  CFGLINKCONTROLASPMCONTROL,
  CFGLINKCONTROLCOMMONCLOCK,
  CFGLINKCONTROLEXTENDEDSYNC,
  CFGLTSSMSTATE,
  CFGPCIELINKSTATEN,
  CFGRDWRDONEN,
  CFGTOTURNOFFN,
  DBGBADDLLPSTATUS,
  DBGBADTLPLCRC,
  DBGBADTLPSEQNUM,
  DBGBADTLPSTATUS,
  DBGDLPROTOCOLSTATUS,
  DBGFCPROTOCOLERRSTATUS,
  DBGMLFRMDLENGTH,
  DBGMLFRMDMPS,
  DBGMLFRMDTCVC,
  DBGMLFRMDTLPSTATUS,
  DBGMLFRMDUNRECTYPE,
  DBGPOISTLPSTATUS,
  DBGRCVROVERFLOWSTATUS,
  DBGREGDETECTEDCORRECTABLE,
  DBGREGDETECTEDFATAL,
  DBGREGDETECTEDNONFATAL,
  DBGREGDETECTEDUNSUPPORTED,
  DBGRPLYROLLOVERSTATUS,
  DBGRPLYTIMEOUTSTATUS,
  DBGURNOBARHIT,
  DBGURPOISCFGWR,
  DBGURSTATUS,
  DBGURUNSUPMSG,
  MIMRXRADDR,
  MIMRXREN,
  MIMRXWADDR,
  MIMRXWDATA,
  MIMRXWEN,
  MIMTXRADDR,
  MIMTXREN,
  MIMTXWADDR,
  MIMTXWDATA,
  MIMTXWEN,
  PIPEGTPOWERDOWNA,
  PIPEGTPOWERDOWNB,
  PIPEGTTXELECIDLEA,
  PIPEGTTXELECIDLEB,
  PIPERXPOLARITYA,
  PIPERXPOLARITYB,
  PIPERXRESETA,
  PIPERXRESETB,
  PIPETXCHARDISPMODEA,
  PIPETXCHARDISPMODEB,
  PIPETXCHARDISPVALA,
  PIPETXCHARDISPVALB,
  PIPETXCHARISKA,
  PIPETXCHARISKB,
  PIPETXDATAA,
  PIPETXDATAB,
  PIPETXRCVRDETA,
  PIPETXRCVRDETB,
  RECEIVEDHOTRESET,
  TRNFCCPLD,
  TRNFCCPLH,
  TRNFCNPD,
  TRNFCNPH,
  TRNFCPD,
  TRNFCPH,
  TRNLNKUPN,
  TRNRBARHITN,
  TRNRD,
  TRNREOFN,
  TRNRERRFWDN,
  TRNRSOFN,
  TRNRSRCDSCN,
  TRNRSRCRDYN,
  TRNTBUFAV,
  TRNTCFGREQN,
  TRNTDSTRDYN,
  TRNTERRDROPN,
  USERRSTN,
  CFGDEVID,
  CFGDSN,
  CFGDWADDR,
  CFGERRCORN,
  CFGERRCPLABORTN,
  CFGERRCPLTIMEOUTN,
  CFGERRECRCN,
  CFGERRLOCKEDN,
  CFGERRPOSTEDN,
  CFGERRTLPCPLHEADER,
  CFGERRURN,
  CFGINTERRUPTASSERTN,
  CFGINTERRUPTDI,
  CFGINTERRUPTN,
  CFGPMWAKEN,
  CFGRDENN,
  CFGREVID,
  CFGSUBSYSID,
  CFGSUBSYSVENID,
  CFGTRNPENDINGN,
  CFGTURNOFFOKN,
  CFGVENID,
  CLOCKLOCKED,
  MGTCLK,
  MIMRXRDATA,
  MIMTXRDATA,
  PIPEGTRESETDONEA,
  PIPEGTRESETDONEB,
  PIPEPHYSTATUSA,
  PIPEPHYSTATUSB,
  PIPERXCHARISKA,
  PIPERXCHARISKB,
  PIPERXDATAA,
  PIPERXDATAB,
  PIPERXENTERELECIDLEA,
  PIPERXENTERELECIDLEB,
  PIPERXSTATUSA,
  PIPERXSTATUSB,
  SYSRESETN,
  TRNFCSEL,
  TRNRDSTRDYN,
  TRNRNPOKN,
  TRNTCFGGNTN,
  TRNTD,
  TRNTEOFN,
  TRNTERRFWDN,
  TRNTSOFN,
  TRNTSRCDSCN,
  TRNTSRCRDYN,
  TRNTSTRN,
  USERCLK
);

  parameter LOC = "UNPLACED";
  parameter [31:0] BAR0 = 32'h00000000;
  parameter [31:0] BAR1 = 32'h00000000;
  parameter [31:0] BAR2 = 32'h00000000;
  parameter [31:0] BAR3 = 32'h00000000;
  parameter [31:0] BAR4 = 32'h00000000;
  parameter [31:0] BAR5 = 32'h00000000;
  parameter [31:0] CARDBUS_CIS_POINTER = 32'h00000000;
  parameter [23:0] CLASS_CODE = 24'h000000;
  parameter integer DEV_CAP_ENDPOINT_L0S_LATENCY = 7;
  parameter integer DEV_CAP_ENDPOINT_L1_LATENCY = 7;
  parameter DEV_CAP_EXT_TAG_SUPPORTED = "FALSE";
  parameter integer DEV_CAP_MAX_PAYLOAD_SUPPORTED = 2;
  parameter integer DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT = 0;
  parameter DEV_CAP_ROLE_BASED_ERROR = "TRUE";
  parameter DISABLE_BAR_FILTERING = "FALSE";
  parameter DISABLE_ID_CHECK = "FALSE";
  parameter DISABLE_SCRAMBLING = "FALSE";
  parameter ENABLE_RX_TD_ECRC_TRIM = "FALSE";
  parameter [21:0] EXPANSION_ROM = 22'h000000;
  parameter FAST_TRAIN = "FALSE";
  parameter integer GTP_SEL = 0;
  parameter integer LINK_CAP_ASPM_SUPPORT = 1;
  parameter integer LINK_CAP_L0S_EXIT_LATENCY = 7;
  parameter integer LINK_CAP_L1_EXIT_LATENCY = 7;
  parameter LINK_STATUS_SLOT_CLOCK_CONFIG = "FALSE";
  parameter [14:0] LL_ACK_TIMEOUT = 15'h0204;
  parameter LL_ACK_TIMEOUT_EN = "FALSE";
  parameter [14:0] LL_REPLAY_TIMEOUT = 15'h060D;
  parameter LL_REPLAY_TIMEOUT_EN = "FALSE";
  parameter integer MSI_CAP_MULTIMSGCAP = 0;
  parameter integer MSI_CAP_MULTIMSG_EXTENSION = 0;
  parameter [3:0] PCIE_CAP_CAPABILITY_VERSION = 4'h1;
  parameter [3:0] PCIE_CAP_DEVICE_PORT_TYPE = 4'h0;
  parameter [4:0] PCIE_CAP_INT_MSG_NUM = 5'b00000;
  parameter PCIE_CAP_SLOT_IMPLEMENTED = "FALSE";
  parameter [11:0] PCIE_GENERIC = 12'h000;
  parameter PLM_AUTO_CONFIG = "FALSE";
  parameter integer PM_CAP_AUXCURRENT = 0;
  parameter PM_CAP_D1SUPPORT = "TRUE";
  parameter PM_CAP_D2SUPPORT = "TRUE";
  parameter PM_CAP_DSI = "FALSE";
  parameter [4:0] PM_CAP_PMESUPPORT = 5'b01111;
  parameter PM_CAP_PME_CLOCK = "FALSE";
  parameter integer PM_CAP_VERSION = 3;
  parameter [7:0] PM_DATA0 = 8'h1E;
  parameter [7:0] PM_DATA1 = 8'h1E;
  parameter [7:0] PM_DATA2 = 8'h1E;
  parameter [7:0] PM_DATA3 = 8'h1E;
  parameter [7:0] PM_DATA4 = 8'h1E;
  parameter [7:0] PM_DATA5 = 8'h1E;
  parameter [7:0] PM_DATA6 = 8'h1E;
  parameter [7:0] PM_DATA7 = 8'h1E;
  parameter [1:0] PM_DATA_SCALE0 = 2'b01;
  parameter [1:0] PM_DATA_SCALE1 = 2'b01;
  parameter [1:0] PM_DATA_SCALE2 = 2'b01;
  parameter [1:0] PM_DATA_SCALE3 = 2'b01;
  parameter [1:0] PM_DATA_SCALE4 = 2'b01;
  parameter [1:0] PM_DATA_SCALE5 = 2'b01;
  parameter [1:0] PM_DATA_SCALE6 = 2'b01;
  parameter [1:0] PM_DATA_SCALE7 = 2'b01;
  parameter SIM_VERSION = "1.0";
  parameter SLOT_CAP_ATT_BUTTON_PRESENT = "FALSE";
  parameter SLOT_CAP_ATT_INDICATOR_PRESENT = "FALSE";
  parameter SLOT_CAP_POWER_INDICATOR_PRESENT = "FALSE";
  parameter integer TL_RX_RAM_RADDR_LATENCY = 1;
  parameter integer TL_RX_RAM_RDATA_LATENCY = 2;
  parameter integer TL_RX_RAM_WRITE_LATENCY = 0;
  parameter TL_TFC_DISABLE = "FALSE";
  parameter TL_TX_CHECKS_DISABLE = "FALSE";
  parameter integer TL_TX_RAM_RADDR_LATENCY = 0;
  parameter integer TL_TX_RAM_RDATA_LATENCY = 2;
  parameter USR_CFG = "FALSE";
  parameter USR_EXT_CFG = "FALSE";
  parameter VC0_CPL_INFINITE = "TRUE";
  parameter [11:0] VC0_RX_RAM_LIMIT = 12'h01E;
  parameter integer VC0_TOTAL_CREDITS_CD = 104;
  parameter integer VC0_TOTAL_CREDITS_CH = 36;
  parameter integer VC0_TOTAL_CREDITS_NPH = 8;
  parameter integer VC0_TOTAL_CREDITS_PD = 288;
  parameter integer VC0_TOTAL_CREDITS_PH = 32;
  parameter integer VC0_TX_LASTPACKET = 31;
  
  localparam in_delay = 0;
  localparam out_delay = 0;
  localparam INCLK_DELAY = 0;
  localparam OUTCLK_DELAY = 0;
  localparam MODULE_NAME = "X_PCIE_A1";

  output CFGCOMMANDBUSMASTERENABLE;
  output CFGCOMMANDINTERRUPTDISABLE;
  output CFGCOMMANDIOENABLE;
  output CFGCOMMANDMEMENABLE;
  output CFGCOMMANDSERREN;
  output CFGDEVCONTROLAUXPOWEREN;
  output CFGDEVCONTROLCORRERRREPORTINGEN;
  output CFGDEVCONTROLENABLERO;
  output CFGDEVCONTROLEXTTAGEN;
  output CFGDEVCONTROLFATALERRREPORTINGEN;
  output CFGDEVCONTROLNONFATALREPORTINGEN;
  output CFGDEVCONTROLNOSNOOPEN;
  output CFGDEVCONTROLPHANTOMEN;
  output CFGDEVCONTROLURERRREPORTINGEN;
  output CFGDEVSTATUSCORRERRDETECTED;
  output CFGDEVSTATUSFATALERRDETECTED;
  output CFGDEVSTATUSNONFATALERRDETECTED;
  output CFGDEVSTATUSURDETECTED;
  output CFGERRCPLRDYN;
  output CFGINTERRUPTMSIENABLE;
  output CFGINTERRUPTRDYN;
  output CFGLINKCONTOLRCB;
  output CFGLINKCONTROLCOMMONCLOCK;
  output CFGLINKCONTROLEXTENDEDSYNC;
  output CFGRDWRDONEN;
  output CFGTOTURNOFFN;
  output DBGBADDLLPSTATUS;
  output DBGBADTLPLCRC;
  output DBGBADTLPSEQNUM;
  output DBGBADTLPSTATUS;
  output DBGDLPROTOCOLSTATUS;
  output DBGFCPROTOCOLERRSTATUS;
  output DBGMLFRMDLENGTH;
  output DBGMLFRMDMPS;
  output DBGMLFRMDTCVC;
  output DBGMLFRMDTLPSTATUS;
  output DBGMLFRMDUNRECTYPE;
  output DBGPOISTLPSTATUS;
  output DBGRCVROVERFLOWSTATUS;
  output DBGREGDETECTEDCORRECTABLE;
  output DBGREGDETECTEDFATAL;
  output DBGREGDETECTEDNONFATAL;
  output DBGREGDETECTEDUNSUPPORTED;
  output DBGRPLYROLLOVERSTATUS;
  output DBGRPLYTIMEOUTSTATUS;
  output DBGURNOBARHIT;
  output DBGURPOISCFGWR;
  output DBGURSTATUS;
  output DBGURUNSUPMSG;
  output MIMRXREN;
  output MIMRXWEN;
  output MIMTXREN;
  output MIMTXWEN;
  output PIPEGTTXELECIDLEA;
  output PIPEGTTXELECIDLEB;
  output PIPERXPOLARITYA;
  output PIPERXPOLARITYB;
  output PIPERXRESETA;
  output PIPERXRESETB;
  output PIPETXRCVRDETA;
  output PIPETXRCVRDETB;
  output RECEIVEDHOTRESET;
  output TRNLNKUPN;
  output TRNREOFN;
  output TRNRERRFWDN;
  output TRNRSOFN;
  output TRNRSRCDSCN;
  output TRNRSRCRDYN;
  output TRNTCFGREQN;
  output TRNTDSTRDYN;
  output TRNTERRDROPN;
  output USERRSTN;
  output [11:0] MIMRXRADDR;
  output [11:0] MIMRXWADDR;
  output [11:0] MIMTXRADDR;
  output [11:0] MIMTXWADDR;
  output [11:0] TRNFCCPLD;
  output [11:0] TRNFCNPD;
  output [11:0] TRNFCPD;
  output [15:0] PIPETXDATAA;
  output [15:0] PIPETXDATAB;
  output [1:0] CFGLINKCONTROLASPMCONTROL;
  output [1:0] PIPEGTPOWERDOWNA;
  output [1:0] PIPEGTPOWERDOWNB;
  output [1:0] PIPETXCHARDISPMODEA;
  output [1:0] PIPETXCHARDISPMODEB;
  output [1:0] PIPETXCHARDISPVALA;
  output [1:0] PIPETXCHARDISPVALB;
  output [1:0] PIPETXCHARISKA;
  output [1:0] PIPETXCHARISKB;
  output [2:0] CFGDEVCONTROLMAXPAYLOAD;
  output [2:0] CFGDEVCONTROLMAXREADREQ;
  output [2:0] CFGFUNCTIONNUMBER;
  output [2:0] CFGINTERRUPTMMENABLE;
  output [2:0] CFGPCIELINKSTATEN;
  output [31:0] CFGDO;
  output [31:0] TRNRD;
  output [34:0] MIMRXWDATA;
  output [35:0] MIMTXWDATA;
  output [4:0] CFGDEVICENUMBER;
  output [4:0] CFGLTSSMSTATE;
  output [5:0] TRNTBUFAV;
  output [6:0] TRNRBARHITN;
  output [7:0] CFGBUSNUMBER;
  output [7:0] CFGINTERRUPTDO;
  output [7:0] TRNFCCPLH;
  output [7:0] TRNFCNPH;
  output [7:0] TRNFCPH;

  input CFGERRCORN;
  input CFGERRCPLABORTN;
  input CFGERRCPLTIMEOUTN;
  input CFGERRECRCN;
  input CFGERRLOCKEDN;
  input CFGERRPOSTEDN;
  input CFGERRURN;
  input CFGINTERRUPTASSERTN;
  input CFGINTERRUPTN;
  input CFGPMWAKEN;
  input CFGRDENN;
  input CFGTRNPENDINGN;
  input CFGTURNOFFOKN;
  input CLOCKLOCKED;
  input MGTCLK;
  input PIPEGTRESETDONEA;
  input PIPEGTRESETDONEB;
  input PIPEPHYSTATUSA;
  input PIPEPHYSTATUSB;
  input PIPERXENTERELECIDLEA;
  input PIPERXENTERELECIDLEB;
  input SYSRESETN;
  input TRNRDSTRDYN;
  input TRNRNPOKN;
  input TRNTCFGGNTN;
  input TRNTEOFN;
  input TRNTERRFWDN;
  input TRNTSOFN;
  input TRNTSRCDSCN;
  input TRNTSRCRDYN;
  input TRNTSTRN;
  input USERCLK;
  input [15:0] CFGDEVID;
  input [15:0] CFGSUBSYSID;
  input [15:0] CFGSUBSYSVENID;
  input [15:0] CFGVENID;
  input [15:0] PIPERXDATAA;
  input [15:0] PIPERXDATAB;
  input [1:0] PIPERXCHARISKA;
  input [1:0] PIPERXCHARISKB;
  input [2:0] PIPERXSTATUSA;
  input [2:0] PIPERXSTATUSB;
  input [2:0] TRNFCSEL;
  input [31:0] TRNTD;
  input [34:0] MIMRXRDATA;
  input [35:0] MIMTXRDATA;
  input [47:0] CFGERRTLPCPLHEADER;
  input [63:0] CFGDSN;
  input [7:0] CFGINTERRUPTDI;
  input [7:0] CFGREVID;
  input [9:0] CFGDWADDR;

  reg DEV_CAP_EXT_TAG_SUPPORTED_BINARY;
  reg DEV_CAP_ROLE_BASED_ERROR_BINARY;
  reg DISABLE_BAR_FILTERING_BINARY;
  reg DISABLE_ID_CHECK_BINARY;
  reg DISABLE_SCRAMBLING_BINARY;
  reg ENABLE_RX_TD_ECRC_TRIM_BINARY;
  reg FAST_TRAIN_BINARY;
  reg GTP_SEL_BINARY;
  reg LINK_STATUS_SLOT_CLOCK_CONFIG_BINARY;
  reg LL_ACK_TIMEOUT_EN_BINARY;
  reg LL_REPLAY_TIMEOUT_EN_BINARY;
  reg MSI_CAP_MULTIMSG_EXTENSION_BINARY;
  reg PCIE_CAP_SLOT_IMPLEMENTED_BINARY;
  reg PLM_AUTO_CONFIG_BINARY;
  reg PM_CAP_D1SUPPORT_BINARY;
  reg PM_CAP_D2SUPPORT_BINARY;
  reg PM_CAP_DSI_BINARY;
  reg PM_CAP_PME_CLOCK_BINARY;
  reg SIM_VERSION_BINARY;
  reg SLOT_CAP_ATT_BUTTON_PRESENT_BINARY;
  reg SLOT_CAP_ATT_INDICATOR_PRESENT_BINARY;
  reg SLOT_CAP_POWER_INDICATOR_PRESENT_BINARY;
  reg TL_RX_RAM_RADDR_LATENCY_BINARY;
  reg TL_RX_RAM_WRITE_LATENCY_BINARY;
  reg TL_TFC_DISABLE_BINARY;
  reg TL_TX_CHECKS_DISABLE_BINARY;
  reg TL_TX_RAM_RADDR_LATENCY_BINARY;
  reg USR_CFG_BINARY;
  reg USR_EXT_CFG_BINARY;
  reg VC0_CPL_INFINITE_BINARY;
  reg [10:0] VC0_TOTAL_CREDITS_CD_BINARY;
  reg [10:0] VC0_TOTAL_CREDITS_PD_BINARY;
  reg [1:0] DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT_BINARY;
  reg [1:0] LINK_CAP_ASPM_SUPPORT_BINARY;
  reg [1:0] PM_DATA_SCALE0_BINARY;
  reg [1:0] PM_DATA_SCALE1_BINARY;
  reg [1:0] PM_DATA_SCALE2_BINARY;
  reg [1:0] PM_DATA_SCALE3_BINARY;
  reg [1:0] PM_DATA_SCALE4_BINARY;
  reg [1:0] PM_DATA_SCALE5_BINARY;
  reg [1:0] PM_DATA_SCALE6_BINARY;
  reg [1:0] PM_DATA_SCALE7_BINARY;
  reg [1:0] TL_RX_RAM_RDATA_LATENCY_BINARY;
  reg [1:0] TL_TX_RAM_RDATA_LATENCY_BINARY;
  reg [2:0] DEV_CAP_ENDPOINT_L0S_LATENCY_BINARY;
  reg [2:0] DEV_CAP_ENDPOINT_L1_LATENCY_BINARY;
  reg [2:0] DEV_CAP_MAX_PAYLOAD_SUPPORTED_BINARY;
  reg [2:0] LINK_CAP_L0S_EXIT_LATENCY_BINARY;
  reg [2:0] LINK_CAP_L1_EXIT_LATENCY_BINARY;
  reg [2:0] MSI_CAP_MULTIMSGCAP_BINARY;
  reg [2:0] PM_CAP_AUXCURRENT_BINARY;
  reg [2:0] PM_CAP_VERSION_BINARY;
  reg [4:0] PCIE_CAP_INT_MSG_NUM_BINARY;
  reg [4:0] PM_CAP_PMESUPPORT_BINARY;
  reg [4:0] VC0_TX_LASTPACKET_BINARY;
  reg [6:0] VC0_TOTAL_CREDITS_CH_BINARY;
  reg [6:0] VC0_TOTAL_CREDITS_NPH_BINARY;
  reg [6:0] VC0_TOTAL_CREDITS_PH_BINARY;

  tri0 GSR = glbl.GSR;
  reg notifier=0;

  wire CFGCOMMANDBUSMASTERENABLE_OUT;
  wire CFGCOMMANDINTERRUPTDISABLE_OUT;
  wire CFGCOMMANDIOENABLE_OUT;
  wire CFGCOMMANDMEMENABLE_OUT;
  wire CFGCOMMANDSERREN_OUT;
  wire CFGDEVCONTROLAUXPOWEREN_OUT;
  wire CFGDEVCONTROLCORRERRREPORTINGEN_OUT;
  wire CFGDEVCONTROLENABLERO_OUT;
  wire CFGDEVCONTROLEXTTAGEN_OUT;
  wire CFGDEVCONTROLFATALERRREPORTINGEN_OUT;
  wire CFGDEVCONTROLNONFATALREPORTINGEN_OUT;
  wire CFGDEVCONTROLNOSNOOPEN_OUT;
  wire CFGDEVCONTROLPHANTOMEN_OUT;
  wire CFGDEVCONTROLURERRREPORTINGEN_OUT;
  wire CFGDEVSTATUSCORRERRDETECTED_OUT;
  wire CFGDEVSTATUSFATALERRDETECTED_OUT;
  wire CFGDEVSTATUSNONFATALERRDETECTED_OUT;
  wire CFGDEVSTATUSURDETECTED_OUT;
  wire CFGERRCPLRDYN_OUT;
  wire CFGINTERRUPTMSIENABLE_OUT;
  wire CFGINTERRUPTRDYN_OUT;
  wire CFGLINKCONTOLRCB_OUT;
  wire CFGLINKCONTROLCOMMONCLOCK_OUT;
  wire CFGLINKCONTROLEXTENDEDSYNC_OUT;
  wire CFGRDWRDONEN_OUT;
  wire CFGTOTURNOFFN_OUT;
  wire DBGBADDLLPSTATUS_OUT;
  wire DBGBADTLPLCRC_OUT;
  wire DBGBADTLPSEQNUM_OUT;
  wire DBGBADTLPSTATUS_OUT;
  wire DBGDLPROTOCOLSTATUS_OUT;
  wire DBGFCPROTOCOLERRSTATUS_OUT;
  wire DBGMLFRMDLENGTH_OUT;
  wire DBGMLFRMDMPS_OUT;
  wire DBGMLFRMDTCVC_OUT;
  wire DBGMLFRMDTLPSTATUS_OUT;
  wire DBGMLFRMDUNRECTYPE_OUT;
  wire DBGPOISTLPSTATUS_OUT;
  wire DBGRCVROVERFLOWSTATUS_OUT;
  wire DBGREGDETECTEDCORRECTABLE_OUT;
  wire DBGREGDETECTEDFATAL_OUT;
  wire DBGREGDETECTEDNONFATAL_OUT;
  wire DBGREGDETECTEDUNSUPPORTED_OUT;
  wire DBGRPLYROLLOVERSTATUS_OUT;
  wire DBGRPLYTIMEOUTSTATUS_OUT;
  wire DBGURNOBARHIT_OUT;
  wire DBGURPOISCFGWR_OUT;
  wire DBGURSTATUS_OUT;
  wire DBGURUNSUPMSG_OUT;
  wire MIMRXREN_OUT;
  wire MIMRXWEN_OUT;
  wire MIMTXREN_OUT;
  wire MIMTXWEN_OUT;
  wire PIPEGTTXELECIDLEA_OUT;
  wire PIPEGTTXELECIDLEB_OUT;
  wire PIPERXPOLARITYA_OUT;
  wire PIPERXPOLARITYB_OUT;
  wire PIPERXRESETA_OUT;
  wire PIPERXRESETB_OUT;
  wire PIPETXRCVRDETA_OUT;
  wire PIPETXRCVRDETB_OUT;
  wire RECEIVEDHOTRESET_OUT;
  wire TRNLNKUPN_OUT;
  wire TRNREOFN_OUT;
  wire TRNRERRFWDN_OUT;
  wire TRNRSOFN_OUT;
  wire TRNRSRCDSCN_OUT;
  wire TRNRSRCRDYN_OUT;
  wire TRNTCFGREQN_OUT;
  wire TRNTDSTRDYN_OUT;
  wire TRNTERRDROPN_OUT;
  wire USERRSTN_OUT;
  wire [11:0] MIMRXRADDR_OUT;
  wire [11:0] MIMRXWADDR_OUT;
  wire [11:0] MIMTXRADDR_OUT;
  wire [11:0] MIMTXWADDR_OUT;
  wire [11:0] TRNFCCPLD_OUT;
  wire [11:0] TRNFCNPD_OUT;
  wire [11:0] TRNFCPD_OUT;
  wire [15:0] PIPETXDATAA_OUT;
  wire [15:0] PIPETXDATAB_OUT;
  wire [1:0] CFGLINKCONTROLASPMCONTROL_OUT;
  wire [1:0] PIPEGTPOWERDOWNA_OUT;
  wire [1:0] PIPEGTPOWERDOWNB_OUT;
  wire [1:0] PIPETXCHARDISPMODEA_OUT;
  wire [1:0] PIPETXCHARDISPMODEB_OUT;
  wire [1:0] PIPETXCHARDISPVALA_OUT;
  wire [1:0] PIPETXCHARDISPVALB_OUT;
  wire [1:0] PIPETXCHARISKA_OUT;
  wire [1:0] PIPETXCHARISKB_OUT;
  wire [2:0] CFGDEVCONTROLMAXPAYLOAD_OUT;
  wire [2:0] CFGDEVCONTROLMAXREADREQ_OUT;
  wire [2:0] CFGFUNCTIONNUMBER_OUT;
  wire [2:0] CFGINTERRUPTMMENABLE_OUT;
  wire [2:0] CFGPCIELINKSTATEN_OUT;
  wire [31:0] CFGDO_OUT;
  wire [31:0] TRNRD_OUT;
  wire [34:0] MIMRXWDATA_OUT;
  wire [35:0] MIMTXWDATA_OUT;
  wire [4:0] CFGDEVICENUMBER_OUT;
  wire [4:0] CFGLTSSMSTATE_OUT;
  wire [5:0] TRNTBUFAV_OUT;
  wire [6:0] TRNRBARHITN_OUT;
  wire [7:0] CFGBUSNUMBER_OUT;
  wire [7:0] CFGINTERRUPTDO_OUT;
  wire [7:0] TRNFCCPLH_OUT;
  wire [7:0] TRNFCNPH_OUT;
  wire [7:0] TRNFCPH_OUT;

  wire CFGCOMMANDBUSMASTERENABLE_OUTDELAY;
  wire CFGCOMMANDINTERRUPTDISABLE_OUTDELAY;
  wire CFGCOMMANDIOENABLE_OUTDELAY;
  wire CFGCOMMANDMEMENABLE_OUTDELAY;
  wire CFGCOMMANDSERREN_OUTDELAY;
  wire CFGDEVCONTROLAUXPOWEREN_OUTDELAY;
  wire CFGDEVCONTROLCORRERRREPORTINGEN_OUTDELAY;
  wire CFGDEVCONTROLENABLERO_OUTDELAY;
  wire CFGDEVCONTROLEXTTAGEN_OUTDELAY;
  wire CFGDEVCONTROLFATALERRREPORTINGEN_OUTDELAY;
  wire CFGDEVCONTROLNONFATALREPORTINGEN_OUTDELAY;
  wire CFGDEVCONTROLNOSNOOPEN_OUTDELAY;
  wire CFGDEVCONTROLPHANTOMEN_OUTDELAY;
  wire CFGDEVCONTROLURERRREPORTINGEN_OUTDELAY;
  wire CFGDEVSTATUSCORRERRDETECTED_OUTDELAY;
  wire CFGDEVSTATUSFATALERRDETECTED_OUTDELAY;
  wire CFGDEVSTATUSNONFATALERRDETECTED_OUTDELAY;
  wire CFGDEVSTATUSURDETECTED_OUTDELAY;
  wire CFGERRCPLRDYN_OUTDELAY;
  wire CFGINTERRUPTMSIENABLE_OUTDELAY;
  wire CFGINTERRUPTRDYN_OUTDELAY;
  wire CFGLINKCONTOLRCB_OUTDELAY;
  wire CFGLINKCONTROLCOMMONCLOCK_OUTDELAY;
  wire CFGLINKCONTROLEXTENDEDSYNC_OUTDELAY;
  wire CFGRDWRDONEN_OUTDELAY;
  wire CFGTOTURNOFFN_OUTDELAY;
  wire DBGBADDLLPSTATUS_OUTDELAY;
  wire DBGBADTLPLCRC_OUTDELAY;
  wire DBGBADTLPSEQNUM_OUTDELAY;
  wire DBGBADTLPSTATUS_OUTDELAY;
  wire DBGDLPROTOCOLSTATUS_OUTDELAY;
  wire DBGFCPROTOCOLERRSTATUS_OUTDELAY;
  wire DBGMLFRMDLENGTH_OUTDELAY;
  wire DBGMLFRMDMPS_OUTDELAY;
  wire DBGMLFRMDTCVC_OUTDELAY;
  wire DBGMLFRMDTLPSTATUS_OUTDELAY;
  wire DBGMLFRMDUNRECTYPE_OUTDELAY;
  wire DBGPOISTLPSTATUS_OUTDELAY;
  wire DBGRCVROVERFLOWSTATUS_OUTDELAY;
  wire DBGREGDETECTEDCORRECTABLE_OUTDELAY;
  wire DBGREGDETECTEDFATAL_OUTDELAY;
  wire DBGREGDETECTEDNONFATAL_OUTDELAY;
  wire DBGREGDETECTEDUNSUPPORTED_OUTDELAY;
  wire DBGRPLYROLLOVERSTATUS_OUTDELAY;
  wire DBGRPLYTIMEOUTSTATUS_OUTDELAY;
  wire DBGURNOBARHIT_OUTDELAY;
  wire DBGURPOISCFGWR_OUTDELAY;
  wire DBGURSTATUS_OUTDELAY;
  wire DBGURUNSUPMSG_OUTDELAY;
  wire MIMRXREN_OUTDELAY;
  wire MIMRXWEN_OUTDELAY;
  wire MIMTXREN_OUTDELAY;
  wire MIMTXWEN_OUTDELAY;
  wire PIPEGTTXELECIDLEA_OUTDELAY;
  wire PIPEGTTXELECIDLEB_OUTDELAY;
  wire PIPERXPOLARITYA_OUTDELAY;
  wire PIPERXPOLARITYB_OUTDELAY;
  wire PIPERXRESETA_OUTDELAY;
  wire PIPERXRESETB_OUTDELAY;
  wire PIPETXRCVRDETA_OUTDELAY;
  wire PIPETXRCVRDETB_OUTDELAY;
  wire RECEIVEDHOTRESET_OUTDELAY;
  wire TRNLNKUPN_OUTDELAY;
  wire TRNREOFN_OUTDELAY;
  wire TRNRERRFWDN_OUTDELAY;
  wire TRNRSOFN_OUTDELAY;
  wire TRNRSRCDSCN_OUTDELAY;
  wire TRNRSRCRDYN_OUTDELAY;
  wire TRNTCFGREQN_OUTDELAY;
  wire TRNTDSTRDYN_OUTDELAY;
  wire TRNTERRDROPN_OUTDELAY;
  wire USERRSTN_OUTDELAY;
  wire [11:0] MIMRXRADDR_OUTDELAY;
  wire [11:0] MIMRXWADDR_OUTDELAY;
  wire [11:0] MIMTXRADDR_OUTDELAY;
  wire [11:0] MIMTXWADDR_OUTDELAY;
  wire [11:0] TRNFCCPLD_OUTDELAY;
  wire [11:0] TRNFCNPD_OUTDELAY;
  wire [11:0] TRNFCPD_OUTDELAY;
  wire [15:0] PIPETXDATAA_OUTDELAY;
  wire [15:0] PIPETXDATAB_OUTDELAY;
  wire [1:0] CFGLINKCONTROLASPMCONTROL_OUTDELAY;
  wire [1:0] PIPEGTPOWERDOWNA_OUTDELAY;
  wire [1:0] PIPEGTPOWERDOWNB_OUTDELAY;
  wire [1:0] PIPETXCHARDISPMODEA_OUTDELAY;
  wire [1:0] PIPETXCHARDISPMODEB_OUTDELAY;
  wire [1:0] PIPETXCHARDISPVALA_OUTDELAY;
  wire [1:0] PIPETXCHARDISPVALB_OUTDELAY;
  wire [1:0] PIPETXCHARISKA_OUTDELAY;
  wire [1:0] PIPETXCHARISKB_OUTDELAY;
  wire [2:0] CFGDEVCONTROLMAXPAYLOAD_OUTDELAY;
  wire [2:0] CFGDEVCONTROLMAXREADREQ_OUTDELAY;
  wire [2:0] CFGFUNCTIONNUMBER_OUTDELAY;
  wire [2:0] CFGINTERRUPTMMENABLE_OUTDELAY;
  wire [2:0] CFGPCIELINKSTATEN_OUTDELAY;
  wire [31:0] CFGDO_OUTDELAY;
  wire [31:0] TRNRD_OUTDELAY;
  wire [34:0] MIMRXWDATA_OUTDELAY;
  wire [35:0] MIMTXWDATA_OUTDELAY;
  wire [4:0] CFGDEVICENUMBER_OUTDELAY;
  wire [4:0] CFGLTSSMSTATE_OUTDELAY;
  wire [5:0] TRNTBUFAV_OUTDELAY;
  wire [6:0] TRNRBARHITN_OUTDELAY;
  wire [7:0] CFGBUSNUMBER_OUTDELAY;
  wire [7:0] CFGINTERRUPTDO_OUTDELAY;
  wire [7:0] TRNFCCPLH_OUTDELAY;
  wire [7:0] TRNFCNPH_OUTDELAY;
  wire [7:0] TRNFCPH_OUTDELAY;

  wire CFGERRCORN_IN;
  wire CFGERRCPLABORTN_IN;
  wire CFGERRCPLTIMEOUTN_IN;
  wire CFGERRECRCN_IN;
  wire CFGERRLOCKEDN_IN;
  wire CFGERRPOSTEDN_IN;
  wire CFGERRURN_IN;
  wire CFGINTERRUPTASSERTN_IN;
  wire CFGINTERRUPTN_IN;
  wire CFGPMWAKEN_IN;
  wire CFGRDENN_IN;
  wire CFGTRNPENDINGN_IN;
  wire CFGTURNOFFOKN_IN;
  wire CLOCKLOCKED_IN;
  wire MGTCLK_IN;
  wire PIPEGTRESETDONEA_IN;
  wire PIPEGTRESETDONEB_IN;
  wire PIPEPHYSTATUSA_IN;
  wire PIPEPHYSTATUSB_IN;
  wire PIPERXENTERELECIDLEA_IN;
  wire PIPERXENTERELECIDLEB_IN;
  wire SYSRESETN_IN;
  wire TRNRDSTRDYN_IN;
  wire TRNRNPOKN_IN;
  wire TRNTCFGGNTN_IN;
  wire TRNTEOFN_IN;
  wire TRNTERRFWDN_IN;
  wire TRNTSOFN_IN;
  wire TRNTSRCDSCN_IN;
  wire TRNTSRCRDYN_IN;
  wire TRNTSTRN_IN;
  wire USERCLK_IN;
  wire [15:0] CFGDEVID_IN;
  wire [15:0] CFGSUBSYSID_IN;
  wire [15:0] CFGSUBSYSVENID_IN;
  wire [15:0] CFGVENID_IN;
  wire [15:0] PIPERXDATAA_IN;
  wire [15:0] PIPERXDATAB_IN;
  wire [1:0] PIPERXCHARISKA_IN;
  wire [1:0] PIPERXCHARISKB_IN;
  wire [2:0] PIPERXSTATUSA_IN;
  wire [2:0] PIPERXSTATUSB_IN;
  wire [2:0] TRNFCSEL_IN;
  wire [31:0] TRNTD_IN;
  wire [34:0] MIMRXRDATA_IN;
  wire [35:0] MIMTXRDATA_IN;
  wire [47:0] CFGERRTLPCPLHEADER_IN;
  wire [63:0] CFGDSN_IN;
  wire [7:0] CFGINTERRUPTDI_IN;
  wire [7:0] CFGREVID_IN;
  wire [9:0] CFGDWADDR_IN;
  wire CFGERRCORN_INDELAY;
  wire CFGERRCPLABORTN_INDELAY;
  wire CFGERRCPLTIMEOUTN_INDELAY;
  wire CFGERRECRCN_INDELAY;
  wire CFGERRLOCKEDN_INDELAY;
  wire CFGERRPOSTEDN_INDELAY;
  wire CFGERRURN_INDELAY;
  wire CFGINTERRUPTASSERTN_INDELAY;
  wire CFGINTERRUPTN_INDELAY;
  wire CFGPMWAKEN_INDELAY;
  wire CFGRDENN_INDELAY;
  wire CFGTRNPENDINGN_INDELAY;
  wire CFGTURNOFFOKN_INDELAY;
  wire CLOCKLOCKED_INDELAY;
  wire MGTCLK_INDELAY;
  wire PIPEGTRESETDONEA_INDELAY;
  wire PIPEGTRESETDONEB_INDELAY;
  wire PIPEPHYSTATUSA_INDELAY;
  wire PIPEPHYSTATUSB_INDELAY;
  wire PIPERXENTERELECIDLEA_INDELAY;
  wire PIPERXENTERELECIDLEB_INDELAY;
  wire SYSRESETN_INDELAY;
  wire TRNRDSTRDYN_INDELAY;
  wire TRNRNPOKN_INDELAY;
  wire TRNTCFGGNTN_INDELAY;
  wire TRNTEOFN_INDELAY;
  wire TRNTERRFWDN_INDELAY;
  wire TRNTSOFN_INDELAY;
  wire TRNTSRCDSCN_INDELAY;
  wire TRNTSRCRDYN_INDELAY;
  wire TRNTSTRN_INDELAY;
  wire USERCLK_INDELAY;
  wire [15:0] CFGDEVID_INDELAY;
  wire [15:0] CFGSUBSYSID_INDELAY;
  wire [15:0] CFGSUBSYSVENID_INDELAY;
  wire [15:0] CFGVENID_INDELAY;
  wire [15:0] PIPERXDATAA_INDELAY;
  wire [15:0] PIPERXDATAB_INDELAY;
  wire [1:0] PIPERXCHARISKA_INDELAY;
  wire [1:0] PIPERXCHARISKB_INDELAY;
  wire [2:0] PIPERXSTATUSA_INDELAY;
  wire [2:0] PIPERXSTATUSB_INDELAY;
  wire [2:0] TRNFCSEL_INDELAY;
  wire [31:0] TRNTD_INDELAY;
  wire [34:0] MIMRXRDATA_INDELAY;
  wire [35:0] MIMTXRDATA_INDELAY;
  wire [47:0] CFGERRTLPCPLHEADER_INDELAY;
  wire [63:0] CFGDSN_INDELAY;
  wire [7:0] CFGINTERRUPTDI_INDELAY;
  wire [7:0] CFGREVID_INDELAY;
  wire [9:0] CFGDWADDR_INDELAY;

  initial begin
    case (DEV_CAP_EXT_TAG_SUPPORTED[31:0])
      "ALSE" : DEV_CAP_EXT_TAG_SUPPORTED_BINARY = 1'b0;
      "TRUE" : DEV_CAP_EXT_TAG_SUPPORTED_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DEV_CAP_EXT_TAG_SUPPORTED on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DEV_CAP_EXT_TAG_SUPPORTED);
        $finish;
      end
    endcase

    case (DEV_CAP_ROLE_BASED_ERROR[31:0])
      "ALSE" : DEV_CAP_ROLE_BASED_ERROR_BINARY = 1'b0;
      "TRUE" : DEV_CAP_ROLE_BASED_ERROR_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DEV_CAP_ROLE_BASED_ERROR on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DEV_CAP_ROLE_BASED_ERROR);
        $finish;
      end
    endcase

    case (DISABLE_BAR_FILTERING[31:0])
      "ALSE" : DISABLE_BAR_FILTERING_BINARY = 1'b0;
      "TRUE" : DISABLE_BAR_FILTERING_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DISABLE_BAR_FILTERING on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DISABLE_BAR_FILTERING);
        $finish;
      end
    endcase

    case (DISABLE_ID_CHECK[31:0])
      "ALSE" : DISABLE_ID_CHECK_BINARY = 1'b0;
      "TRUE" : DISABLE_ID_CHECK_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DISABLE_ID_CHECK on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DISABLE_ID_CHECK);
        $finish;
      end
    endcase

    case (DISABLE_SCRAMBLING[31:0])
      "ALSE" : DISABLE_SCRAMBLING_BINARY = 1'b0;
      "TRUE" : DISABLE_SCRAMBLING_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DISABLE_SCRAMBLING on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DISABLE_SCRAMBLING);
        $finish;
      end
    endcase

    case (ENABLE_RX_TD_ECRC_TRIM[31:0])
      "ALSE" : ENABLE_RX_TD_ECRC_TRIM_BINARY = 1'b0;
      "TRUE" : ENABLE_RX_TD_ECRC_TRIM_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute ENABLE_RX_TD_ECRC_TRIM on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, ENABLE_RX_TD_ECRC_TRIM);
        $finish;
      end
    endcase

    case (FAST_TRAIN[31:0])
      "ALSE" : FAST_TRAIN_BINARY = 1'b0;
      "TRUE" : FAST_TRAIN_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute FAST_TRAIN on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, FAST_TRAIN);
        $finish;
      end
    endcase

    case (LINK_STATUS_SLOT_CLOCK_CONFIG[31:0])
      "ALSE" : LINK_STATUS_SLOT_CLOCK_CONFIG_BINARY = 1'b0;
      "TRUE" : LINK_STATUS_SLOT_CLOCK_CONFIG_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute LINK_STATUS_SLOT_CLOCK_CONFIG on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, LINK_STATUS_SLOT_CLOCK_CONFIG);
        $finish;
      end
    endcase

    case (LL_ACK_TIMEOUT_EN[31:0])
      "ALSE" : LL_ACK_TIMEOUT_EN_BINARY = 1'b0;
      "TRUE" : LL_ACK_TIMEOUT_EN_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute LL_ACK_TIMEOUT_EN on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, LL_ACK_TIMEOUT_EN);
        $finish;
      end
    endcase

    case (LL_REPLAY_TIMEOUT_EN[31:0])
      "ALSE" : LL_REPLAY_TIMEOUT_EN_BINARY = 1'b0;
      "TRUE" : LL_REPLAY_TIMEOUT_EN_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute LL_REPLAY_TIMEOUT_EN on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, LL_REPLAY_TIMEOUT_EN);
        $finish;
      end
    endcase

    case (PCIE_CAP_SLOT_IMPLEMENTED[31:0])
      "ALSE" : PCIE_CAP_SLOT_IMPLEMENTED_BINARY = 1'b0;
      "TRUE" : PCIE_CAP_SLOT_IMPLEMENTED_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PCIE_CAP_SLOT_IMPLEMENTED on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, PCIE_CAP_SLOT_IMPLEMENTED);
        $finish;
      end
    endcase

    case (PLM_AUTO_CONFIG[31:0])
      "ALSE" : PLM_AUTO_CONFIG_BINARY = 1'b0;
      "TRUE" : PLM_AUTO_CONFIG_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PLM_AUTO_CONFIG on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, PLM_AUTO_CONFIG);
        $finish;
      end
    endcase

    case (PM_CAP_D1SUPPORT[31:0])
      "ALSE" : PM_CAP_D1SUPPORT_BINARY = 1'b0;
      "TRUE" : PM_CAP_D1SUPPORT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PM_CAP_D1SUPPORT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, PM_CAP_D1SUPPORT);
        $finish;
      end
    endcase

    case (PM_CAP_D2SUPPORT[31:0])
      "ALSE" : PM_CAP_D2SUPPORT_BINARY = 1'b0;
      "TRUE" : PM_CAP_D2SUPPORT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PM_CAP_D2SUPPORT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, PM_CAP_D2SUPPORT);
        $finish;
      end
    endcase

    case (PM_CAP_DSI[31:0])
      "ALSE" : PM_CAP_DSI_BINARY = 1'b0;
      "TRUE" : PM_CAP_DSI_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PM_CAP_DSI on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, PM_CAP_DSI);
        $finish;
      end
    endcase

    case (PM_CAP_PME_CLOCK[31:0])
      "ALSE" : PM_CAP_PME_CLOCK_BINARY = 1'b0;
      "TRUE" : PM_CAP_PME_CLOCK_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PM_CAP_PME_CLOCK on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, PM_CAP_PME_CLOCK);
        $finish;
      end
    endcase

    case (SIM_VERSION)
      "1.0" : SIM_VERSION_BINARY = 0;
      "2.0" : SIM_VERSION_BINARY = 0;
      "3.0" : SIM_VERSION_BINARY = 0;
      "4.0" : SIM_VERSION_BINARY = 0;
      "5.0" : SIM_VERSION_BINARY = 0;
      "6.0" : SIM_VERSION_BINARY = 0;
      default : begin
        $display("Attribute Syntax Error : The Attribute SIM_VERSION on %s instance %m is set to %s.  Legal values for this attribute are 1.0, 2.0, 3.0, 4.0, 5.0, or 6.0." ,MODULE_NAME, SIM_VERSION);
        $finish;
      end
    endcase

    case (SLOT_CAP_ATT_BUTTON_PRESENT[31:0])
      "ALSE" : SLOT_CAP_ATT_BUTTON_PRESENT_BINARY = 1'b0;
      "TRUE" : SLOT_CAP_ATT_BUTTON_PRESENT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute SLOT_CAP_ATT_BUTTON_PRESENT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SLOT_CAP_ATT_BUTTON_PRESENT);
        $finish;
      end
    endcase

    case (SLOT_CAP_ATT_INDICATOR_PRESENT[31:0])
      "ALSE" : SLOT_CAP_ATT_INDICATOR_PRESENT_BINARY = 1'b0;
      "TRUE" : SLOT_CAP_ATT_INDICATOR_PRESENT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute SLOT_CAP_ATT_INDICATOR_PRESENT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SLOT_CAP_ATT_INDICATOR_PRESENT);
        $finish;
      end
    endcase

    case (SLOT_CAP_POWER_INDICATOR_PRESENT[31:0])
      "ALSE" : SLOT_CAP_POWER_INDICATOR_PRESENT_BINARY = 1'b0;
      "TRUE" : SLOT_CAP_POWER_INDICATOR_PRESENT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute SLOT_CAP_POWER_INDICATOR_PRESENT on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, SLOT_CAP_POWER_INDICATOR_PRESENT);
        $finish;
      end
    endcase

    case (TL_TFC_DISABLE[31:0])
      "ALSE" : TL_TFC_DISABLE_BINARY = 1'b0;
      "TRUE" : TL_TFC_DISABLE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TL_TFC_DISABLE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, TL_TFC_DISABLE);
        $finish;
      end
    endcase

    case (TL_TX_CHECKS_DISABLE[31:0])
      "ALSE" : TL_TX_CHECKS_DISABLE_BINARY = 1'b0;
      "TRUE" : TL_TX_CHECKS_DISABLE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TL_TX_CHECKS_DISABLE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, TL_TX_CHECKS_DISABLE);
        $finish;
      end
    endcase

    case (USR_CFG[31:0])
      "ALSE" : USR_CFG_BINARY = 1'b0;
      "TRUE" : USR_CFG_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute USR_CFG on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, USR_CFG);
        $finish;
      end
    endcase

    case (USR_EXT_CFG[31:0])
      "ALSE" : USR_EXT_CFG_BINARY = 1'b0;
      "TRUE" : USR_EXT_CFG_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute USR_EXT_CFG on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, USR_EXT_CFG);
        $finish;
      end
    endcase

    case (VC0_CPL_INFINITE[31:0])
      "ALSE" : VC0_CPL_INFINITE_BINARY = 1'b0;
      "TRUE" : VC0_CPL_INFINITE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute VC0_CPL_INFINITE on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, VC0_CPL_INFINITE);
        $finish;
      end
    endcase

    if ((DEV_CAP_ENDPOINT_L0S_LATENCY >= 0) && (DEV_CAP_ENDPOINT_L0S_LATENCY <= 7))
      DEV_CAP_ENDPOINT_L0S_LATENCY_BINARY = DEV_CAP_ENDPOINT_L0S_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute DEV_CAP_ENDPOINT_L0S_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, DEV_CAP_ENDPOINT_L0S_LATENCY);
      $finish;
    end

    if ((DEV_CAP_ENDPOINT_L1_LATENCY >= 0) && (DEV_CAP_ENDPOINT_L1_LATENCY <= 7))
      DEV_CAP_ENDPOINT_L1_LATENCY_BINARY = DEV_CAP_ENDPOINT_L1_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute DEV_CAP_ENDPOINT_L1_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, DEV_CAP_ENDPOINT_L1_LATENCY);
      $finish;
    end

    if ((DEV_CAP_MAX_PAYLOAD_SUPPORTED >= 0) && (DEV_CAP_MAX_PAYLOAD_SUPPORTED <= 7))
      DEV_CAP_MAX_PAYLOAD_SUPPORTED_BINARY = DEV_CAP_MAX_PAYLOAD_SUPPORTED;
    else begin
      $display("Attribute Syntax Error : The Attribute DEV_CAP_MAX_PAYLOAD_SUPPORTED on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, DEV_CAP_MAX_PAYLOAD_SUPPORTED);
      $finish;
    end

    if ((DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT >= 0) && (DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT <= 3))
      DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT_BINARY = DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT;
    else begin
      $display("Attribute Syntax Error : The Attribute DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT);
      $finish;
    end

    if ((GTP_SEL >= 0) && (GTP_SEL <= 1))
      GTP_SEL_BINARY = GTP_SEL;
    else begin
      $display("Attribute Syntax Error : The Attribute GTP_SEL on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, GTP_SEL);
      $finish;
    end

    if ((LINK_CAP_ASPM_SUPPORT >= 0) && (LINK_CAP_ASPM_SUPPORT <= 3))
      LINK_CAP_ASPM_SUPPORT_BINARY = LINK_CAP_ASPM_SUPPORT;
    else begin
      $display("Attribute Syntax Error : The Attribute LINK_CAP_ASPM_SUPPORT on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, LINK_CAP_ASPM_SUPPORT);
      $finish;
    end

    if ((LINK_CAP_L0S_EXIT_LATENCY >= 0) && (LINK_CAP_L0S_EXIT_LATENCY <= 7))
      LINK_CAP_L0S_EXIT_LATENCY_BINARY = LINK_CAP_L0S_EXIT_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute LINK_CAP_L0S_EXIT_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, LINK_CAP_L0S_EXIT_LATENCY);
      $finish;
    end

    if ((LINK_CAP_L1_EXIT_LATENCY >= 0) && (LINK_CAP_L1_EXIT_LATENCY <= 7))
      LINK_CAP_L1_EXIT_LATENCY_BINARY = LINK_CAP_L1_EXIT_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute LINK_CAP_L1_EXIT_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, LINK_CAP_L1_EXIT_LATENCY);
      $finish;
    end

    if ((MSI_CAP_MULTIMSGCAP >= 0) && (MSI_CAP_MULTIMSGCAP <= 7))
      MSI_CAP_MULTIMSGCAP_BINARY = MSI_CAP_MULTIMSGCAP;
    else begin
      $display("Attribute Syntax Error : The Attribute MSI_CAP_MULTIMSGCAP on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, MSI_CAP_MULTIMSGCAP);
      $finish;
    end

    if ((MSI_CAP_MULTIMSG_EXTENSION >= 0) && (MSI_CAP_MULTIMSG_EXTENSION <= 1))
      MSI_CAP_MULTIMSG_EXTENSION_BINARY = MSI_CAP_MULTIMSG_EXTENSION;
    else begin
      $display("Attribute Syntax Error : The Attribute MSI_CAP_MULTIMSG_EXTENSION on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, MSI_CAP_MULTIMSG_EXTENSION);
      $finish;
    end

    if ((PCIE_CAP_INT_MSG_NUM >= 0) && (PCIE_CAP_INT_MSG_NUM <= 31))
      PCIE_CAP_INT_MSG_NUM_BINARY = PCIE_CAP_INT_MSG_NUM;
    else begin
      $display("Attribute Syntax Error : The Attribute PCIE_CAP_INT_MSG_NUM on %s instance %m is set to %d.  Legal values for this attribute are  0 to 31.", MODULE_NAME, PCIE_CAP_INT_MSG_NUM);
      $finish;
    end

    if ((PM_CAP_AUXCURRENT >= 0) && (PM_CAP_AUXCURRENT <= 7))
      PM_CAP_AUXCURRENT_BINARY = PM_CAP_AUXCURRENT;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_CAP_AUXCURRENT on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, PM_CAP_AUXCURRENT);
      $finish;
    end

    if ((PM_CAP_PMESUPPORT >= 0) && (PM_CAP_PMESUPPORT <= 31))
      PM_CAP_PMESUPPORT_BINARY = PM_CAP_PMESUPPORT;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_CAP_PMESUPPORT on %s instance %m is set to %d.  Legal values for this attribute are  0 to 31.", MODULE_NAME,PM_CAP_PMESUPPORT);
      $finish;
    end

    if ((PM_CAP_VERSION >= 0) && (PM_CAP_VERSION <= 7))
      PM_CAP_VERSION_BINARY = PM_CAP_VERSION;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_CAP_VERSION on %s instance %m is set to %d.  Legal values for this attribute are  0 to 7.", MODULE_NAME, PM_CAP_VERSION);
      $finish;
    end

    if ((PM_DATA_SCALE0 >= 0) && (PM_DATA_SCALE0 <= 3))
      PM_DATA_SCALE0_BINARY = PM_DATA_SCALE0;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE0 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE0);
      $finish;
    end

    if ((PM_DATA_SCALE1 >= 0) && (PM_DATA_SCALE1 <= 3))
      PM_DATA_SCALE1_BINARY = PM_DATA_SCALE1;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE1 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE1);
      $finish;
    end

    if ((PM_DATA_SCALE2 >= 0) && (PM_DATA_SCALE2 <= 3))
      PM_DATA_SCALE2_BINARY = PM_DATA_SCALE2;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE2 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE2);
      $finish;
    end

    if ((PM_DATA_SCALE3 >= 0) && (PM_DATA_SCALE3 <= 3))
      PM_DATA_SCALE3_BINARY = PM_DATA_SCALE3;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE3 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE3);
      $finish;
    end

    if ((PM_DATA_SCALE4 >= 0) && (PM_DATA_SCALE4 <= 3))
      PM_DATA_SCALE4_BINARY = PM_DATA_SCALE4;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE4 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE4);
      $finish;
    end

    if ((PM_DATA_SCALE5 >= 0) && (PM_DATA_SCALE5 <= 3))
      PM_DATA_SCALE5_BINARY = PM_DATA_SCALE5;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE5 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE5);
      $finish;
    end

    if ((PM_DATA_SCALE6 >= 0) && (PM_DATA_SCALE6 <= 3))
      PM_DATA_SCALE6_BINARY = PM_DATA_SCALE6;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE6 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE6);
      $finish;
    end

    if ((PM_DATA_SCALE7 >= 0) && (PM_DATA_SCALE7 <= 3))
      PM_DATA_SCALE7_BINARY = PM_DATA_SCALE7;
    else begin
      $display("Attribute Syntax Error : The Attribute PM_DATA_SCALE7 on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, PM_DATA_SCALE7);
      $finish;
    end

    if ((TL_RX_RAM_RADDR_LATENCY >= 0) && (TL_RX_RAM_RADDR_LATENCY <= 1))
      TL_RX_RAM_RADDR_LATENCY_BINARY = TL_RX_RAM_RADDR_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute TL_RX_RAM_RADDR_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, TL_RX_RAM_RADDR_LATENCY);
      $finish;
    end

    if ((TL_RX_RAM_RDATA_LATENCY >= 0) && (TL_RX_RAM_RDATA_LATENCY <= 3))
      TL_RX_RAM_RDATA_LATENCY_BINARY = TL_RX_RAM_RDATA_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute TL_RX_RAM_RDATA_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, TL_RX_RAM_RDATA_LATENCY);
      $finish;
    end

    if ((TL_RX_RAM_WRITE_LATENCY >= 0) && (TL_RX_RAM_WRITE_LATENCY <= 1))
      TL_RX_RAM_WRITE_LATENCY_BINARY = TL_RX_RAM_WRITE_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute TL_RX_RAM_WRITE_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, TL_RX_RAM_WRITE_LATENCY);
      $finish;
    end

    if ((TL_TX_RAM_RADDR_LATENCY >= 0) && (TL_TX_RAM_RADDR_LATENCY <= 1))
      TL_TX_RAM_RADDR_LATENCY_BINARY = TL_TX_RAM_RADDR_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute TL_TX_RAM_RADDR_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 1.", MODULE_NAME, TL_TX_RAM_RADDR_LATENCY);
      $finish;
    end

    if ((TL_TX_RAM_RDATA_LATENCY >= 0) && (TL_TX_RAM_RDATA_LATENCY <= 3))
      TL_TX_RAM_RDATA_LATENCY_BINARY = TL_TX_RAM_RDATA_LATENCY;
    else begin
      $display("Attribute Syntax Error : The Attribute TL_TX_RAM_RDATA_LATENCY on %s instance %m is set to %d.  Legal values for this attribute are  0 to 3.", MODULE_NAME, TL_TX_RAM_RDATA_LATENCY);
      $finish;
    end

    if ((VC0_TOTAL_CREDITS_CD >= 0) && (VC0_TOTAL_CREDITS_CD <= 2047))
      VC0_TOTAL_CREDITS_CD_BINARY = VC0_TOTAL_CREDITS_CD;
    else begin
      $display("Attribute Syntax Error : The Attribute VC0_TOTAL_CREDITS_CD on %s instance %m is set to %d.  Legal values for this attribute are  0 to 2047.", MODULE_NAME, VC0_TOTAL_CREDITS_CD);
      $finish;
    end

    if ((VC0_TOTAL_CREDITS_CH >= 0) && (VC0_TOTAL_CREDITS_CH <= 127))
      VC0_TOTAL_CREDITS_CH_BINARY = VC0_TOTAL_CREDITS_CH;
    else begin
      $display("Attribute Syntax Error : The Attribute VC0_TOTAL_CREDITS_CH on %s instance %m is set to %d.  Legal values for this attribute are  0 to 127.", MODULE_NAME, VC0_TOTAL_CREDITS_CH);
      $finish;
    end

    if ((VC0_TOTAL_CREDITS_NPH >= 0) && (VC0_TOTAL_CREDITS_NPH <= 127))
      VC0_TOTAL_CREDITS_NPH_BINARY = VC0_TOTAL_CREDITS_NPH;
    else begin
      $display("Attribute Syntax Error : The Attribute VC0_TOTAL_CREDITS_NPH on %s instance %m is set to %d.  Legal values for this attribute are  0 to 127.", MODULE_NAME, VC0_TOTAL_CREDITS_NPH);
      $finish;
    end

    if ((VC0_TOTAL_CREDITS_PD >= 0) && (VC0_TOTAL_CREDITS_PD <= 2047))
      VC0_TOTAL_CREDITS_PD_BINARY = VC0_TOTAL_CREDITS_PD;
    else begin
      $display("Attribute Syntax Error : The Attribute VC0_TOTAL_CREDITS_PD on %s instance %m is set to %d.  Legal values for this attribute are  0 to 2047.", MODULE_NAME, VC0_TOTAL_CREDITS_PD);
      $finish;
    end

    if ((VC0_TOTAL_CREDITS_PH >= 0) && (VC0_TOTAL_CREDITS_PH <= 127))
      VC0_TOTAL_CREDITS_PH_BINARY = VC0_TOTAL_CREDITS_PH;
    else begin
      $display("Attribute Syntax Error : The Attribute VC0_TOTAL_CREDITS_PH on %s instance %m is set to %d.  Legal values for this attribute are  0 to 127.", MODULE_NAME, VC0_TOTAL_CREDITS_PH);
      $finish;
    end

    if ((VC0_TX_LASTPACKET >= 0) && (VC0_TX_LASTPACKET <= 31))
      VC0_TX_LASTPACKET_BINARY = VC0_TX_LASTPACKET;
    else begin
      $display("Attribute Syntax Error : The Attribute VC0_TX_LASTPACKET on %s instance %m is set to %d.  Legal values for this attribute are  0 to 31.", MODULE_NAME, VC0_TX_LASTPACKET);
      $finish;
    end

  end


  buf B_CFGBUSNUMBER0 (CFGBUSNUMBER[0], CFGBUSNUMBER_OUTDELAY[0]);
  buf B_CFGBUSNUMBER1 (CFGBUSNUMBER[1], CFGBUSNUMBER_OUTDELAY[1]);
  buf B_CFGBUSNUMBER2 (CFGBUSNUMBER[2], CFGBUSNUMBER_OUTDELAY[2]);
  buf B_CFGBUSNUMBER3 (CFGBUSNUMBER[3], CFGBUSNUMBER_OUTDELAY[3]);
  buf B_CFGBUSNUMBER4 (CFGBUSNUMBER[4], CFGBUSNUMBER_OUTDELAY[4]);
  buf B_CFGBUSNUMBER5 (CFGBUSNUMBER[5], CFGBUSNUMBER_OUTDELAY[5]);
  buf B_CFGBUSNUMBER6 (CFGBUSNUMBER[6], CFGBUSNUMBER_OUTDELAY[6]);
  buf B_CFGBUSNUMBER7 (CFGBUSNUMBER[7], CFGBUSNUMBER_OUTDELAY[7]);
  buf B_CFGCOMMANDBUSMASTERENABLE (CFGCOMMANDBUSMASTERENABLE, CFGCOMMANDBUSMASTERENABLE_OUTDELAY);
  buf B_CFGCOMMANDINTERRUPTDISABLE (CFGCOMMANDINTERRUPTDISABLE, CFGCOMMANDINTERRUPTDISABLE_OUTDELAY);
  buf B_CFGCOMMANDIOENABLE (CFGCOMMANDIOENABLE, CFGCOMMANDIOENABLE_OUTDELAY);
  buf B_CFGCOMMANDMEMENABLE (CFGCOMMANDMEMENABLE, CFGCOMMANDMEMENABLE_OUTDELAY);
  buf B_CFGCOMMANDSERREN (CFGCOMMANDSERREN, CFGCOMMANDSERREN_OUTDELAY);
  buf B_CFGDEVCONTROLAUXPOWEREN (CFGDEVCONTROLAUXPOWEREN, CFGDEVCONTROLAUXPOWEREN_OUTDELAY);
  buf B_CFGDEVCONTROLCORRERRREPORTINGEN (CFGDEVCONTROLCORRERRREPORTINGEN, CFGDEVCONTROLCORRERRREPORTINGEN_OUTDELAY);
  buf B_CFGDEVCONTROLENABLERO (CFGDEVCONTROLENABLERO, CFGDEVCONTROLENABLERO_OUTDELAY);
  buf B_CFGDEVCONTROLEXTTAGEN (CFGDEVCONTROLEXTTAGEN, CFGDEVCONTROLEXTTAGEN_OUTDELAY);
  buf B_CFGDEVCONTROLFATALERRREPORTINGEN (CFGDEVCONTROLFATALERRREPORTINGEN, CFGDEVCONTROLFATALERRREPORTINGEN_OUTDELAY);
  buf B_CFGDEVCONTROLMAXPAYLOAD0 (CFGDEVCONTROLMAXPAYLOAD[0], CFGDEVCONTROLMAXPAYLOAD_OUTDELAY[0]);
  buf B_CFGDEVCONTROLMAXPAYLOAD1 (CFGDEVCONTROLMAXPAYLOAD[1], CFGDEVCONTROLMAXPAYLOAD_OUTDELAY[1]);
  buf B_CFGDEVCONTROLMAXPAYLOAD2 (CFGDEVCONTROLMAXPAYLOAD[2], CFGDEVCONTROLMAXPAYLOAD_OUTDELAY[2]);
  buf B_CFGDEVCONTROLMAXREADREQ0 (CFGDEVCONTROLMAXREADREQ[0], CFGDEVCONTROLMAXREADREQ_OUTDELAY[0]);
  buf B_CFGDEVCONTROLMAXREADREQ1 (CFGDEVCONTROLMAXREADREQ[1], CFGDEVCONTROLMAXREADREQ_OUTDELAY[1]);
  buf B_CFGDEVCONTROLMAXREADREQ2 (CFGDEVCONTROLMAXREADREQ[2], CFGDEVCONTROLMAXREADREQ_OUTDELAY[2]);
  buf B_CFGDEVCONTROLNONFATALREPORTINGEN (CFGDEVCONTROLNONFATALREPORTINGEN, CFGDEVCONTROLNONFATALREPORTINGEN_OUTDELAY);
  buf B_CFGDEVCONTROLNOSNOOPEN (CFGDEVCONTROLNOSNOOPEN, CFGDEVCONTROLNOSNOOPEN_OUTDELAY);
  buf B_CFGDEVCONTROLPHANTOMEN (CFGDEVCONTROLPHANTOMEN, CFGDEVCONTROLPHANTOMEN_OUTDELAY);
  buf B_CFGDEVCONTROLURERRREPORTINGEN (CFGDEVCONTROLURERRREPORTINGEN, CFGDEVCONTROLURERRREPORTINGEN_OUTDELAY);
  buf B_CFGDEVICENUMBER0 (CFGDEVICENUMBER[0], CFGDEVICENUMBER_OUTDELAY[0]);
  buf B_CFGDEVICENUMBER1 (CFGDEVICENUMBER[1], CFGDEVICENUMBER_OUTDELAY[1]);
  buf B_CFGDEVICENUMBER2 (CFGDEVICENUMBER[2], CFGDEVICENUMBER_OUTDELAY[2]);
  buf B_CFGDEVICENUMBER3 (CFGDEVICENUMBER[3], CFGDEVICENUMBER_OUTDELAY[3]);
  buf B_CFGDEVICENUMBER4 (CFGDEVICENUMBER[4], CFGDEVICENUMBER_OUTDELAY[4]);
  buf B_CFGDEVSTATUSCORRERRDETECTED (CFGDEVSTATUSCORRERRDETECTED, CFGDEVSTATUSCORRERRDETECTED_OUTDELAY);
  buf B_CFGDEVSTATUSFATALERRDETECTED (CFGDEVSTATUSFATALERRDETECTED, CFGDEVSTATUSFATALERRDETECTED_OUTDELAY);
  buf B_CFGDEVSTATUSNONFATALERRDETECTED (CFGDEVSTATUSNONFATALERRDETECTED, CFGDEVSTATUSNONFATALERRDETECTED_OUTDELAY);
  buf B_CFGDEVSTATUSURDETECTED (CFGDEVSTATUSURDETECTED, CFGDEVSTATUSURDETECTED_OUTDELAY);
  buf B_CFGDO0 (CFGDO[0], CFGDO_OUTDELAY[0]);
  buf B_CFGDO1 (CFGDO[1], CFGDO_OUTDELAY[1]);
  buf B_CFGDO10 (CFGDO[10], CFGDO_OUTDELAY[10]);
  buf B_CFGDO11 (CFGDO[11], CFGDO_OUTDELAY[11]);
  buf B_CFGDO12 (CFGDO[12], CFGDO_OUTDELAY[12]);
  buf B_CFGDO13 (CFGDO[13], CFGDO_OUTDELAY[13]);
  buf B_CFGDO14 (CFGDO[14], CFGDO_OUTDELAY[14]);
  buf B_CFGDO15 (CFGDO[15], CFGDO_OUTDELAY[15]);
  buf B_CFGDO16 (CFGDO[16], CFGDO_OUTDELAY[16]);
  buf B_CFGDO17 (CFGDO[17], CFGDO_OUTDELAY[17]);
  buf B_CFGDO18 (CFGDO[18], CFGDO_OUTDELAY[18]);
  buf B_CFGDO19 (CFGDO[19], CFGDO_OUTDELAY[19]);
  buf B_CFGDO2 (CFGDO[2], CFGDO_OUTDELAY[2]);
  buf B_CFGDO20 (CFGDO[20], CFGDO_OUTDELAY[20]);
  buf B_CFGDO21 (CFGDO[21], CFGDO_OUTDELAY[21]);
  buf B_CFGDO22 (CFGDO[22], CFGDO_OUTDELAY[22]);
  buf B_CFGDO23 (CFGDO[23], CFGDO_OUTDELAY[23]);
  buf B_CFGDO24 (CFGDO[24], CFGDO_OUTDELAY[24]);
  buf B_CFGDO25 (CFGDO[25], CFGDO_OUTDELAY[25]);
  buf B_CFGDO26 (CFGDO[26], CFGDO_OUTDELAY[26]);
  buf B_CFGDO27 (CFGDO[27], CFGDO_OUTDELAY[27]);
  buf B_CFGDO28 (CFGDO[28], CFGDO_OUTDELAY[28]);
  buf B_CFGDO29 (CFGDO[29], CFGDO_OUTDELAY[29]);
  buf B_CFGDO3 (CFGDO[3], CFGDO_OUTDELAY[3]);
  buf B_CFGDO30 (CFGDO[30], CFGDO_OUTDELAY[30]);
  buf B_CFGDO31 (CFGDO[31], CFGDO_OUTDELAY[31]);
  buf B_CFGDO4 (CFGDO[4], CFGDO_OUTDELAY[4]);
  buf B_CFGDO5 (CFGDO[5], CFGDO_OUTDELAY[5]);
  buf B_CFGDO6 (CFGDO[6], CFGDO_OUTDELAY[6]);
  buf B_CFGDO7 (CFGDO[7], CFGDO_OUTDELAY[7]);
  buf B_CFGDO8 (CFGDO[8], CFGDO_OUTDELAY[8]);
  buf B_CFGDO9 (CFGDO[9], CFGDO_OUTDELAY[9]);
  buf B_CFGERRCPLRDYN (CFGERRCPLRDYN, CFGERRCPLRDYN_OUTDELAY);
  buf B_CFGFUNCTIONNUMBER0 (CFGFUNCTIONNUMBER[0], CFGFUNCTIONNUMBER_OUTDELAY[0]);
  buf B_CFGFUNCTIONNUMBER1 (CFGFUNCTIONNUMBER[1], CFGFUNCTIONNUMBER_OUTDELAY[1]);
  buf B_CFGFUNCTIONNUMBER2 (CFGFUNCTIONNUMBER[2], CFGFUNCTIONNUMBER_OUTDELAY[2]);
  buf B_CFGINTERRUPTDO0 (CFGINTERRUPTDO[0], CFGINTERRUPTDO_OUTDELAY[0]);
  buf B_CFGINTERRUPTDO1 (CFGINTERRUPTDO[1], CFGINTERRUPTDO_OUTDELAY[1]);
  buf B_CFGINTERRUPTDO2 (CFGINTERRUPTDO[2], CFGINTERRUPTDO_OUTDELAY[2]);
  buf B_CFGINTERRUPTDO3 (CFGINTERRUPTDO[3], CFGINTERRUPTDO_OUTDELAY[3]);
  buf B_CFGINTERRUPTDO4 (CFGINTERRUPTDO[4], CFGINTERRUPTDO_OUTDELAY[4]);
  buf B_CFGINTERRUPTDO5 (CFGINTERRUPTDO[5], CFGINTERRUPTDO_OUTDELAY[5]);
  buf B_CFGINTERRUPTDO6 (CFGINTERRUPTDO[6], CFGINTERRUPTDO_OUTDELAY[6]);
  buf B_CFGINTERRUPTDO7 (CFGINTERRUPTDO[7], CFGINTERRUPTDO_OUTDELAY[7]);
  buf B_CFGINTERRUPTMMENABLE0 (CFGINTERRUPTMMENABLE[0], CFGINTERRUPTMMENABLE_OUTDELAY[0]);
  buf B_CFGINTERRUPTMMENABLE1 (CFGINTERRUPTMMENABLE[1], CFGINTERRUPTMMENABLE_OUTDELAY[1]);
  buf B_CFGINTERRUPTMMENABLE2 (CFGINTERRUPTMMENABLE[2], CFGINTERRUPTMMENABLE_OUTDELAY[2]);
  buf B_CFGINTERRUPTMSIENABLE (CFGINTERRUPTMSIENABLE, CFGINTERRUPTMSIENABLE_OUTDELAY);
  buf B_CFGINTERRUPTRDYN (CFGINTERRUPTRDYN, CFGINTERRUPTRDYN_OUTDELAY);
  buf B_CFGLINKCONTOLRCB (CFGLINKCONTOLRCB, CFGLINKCONTOLRCB_OUTDELAY);
  buf B_CFGLINKCONTROLASPMCONTROL0 (CFGLINKCONTROLASPMCONTROL[0], CFGLINKCONTROLASPMCONTROL_OUTDELAY[0]);
  buf B_CFGLINKCONTROLASPMCONTROL1 (CFGLINKCONTROLASPMCONTROL[1], CFGLINKCONTROLASPMCONTROL_OUTDELAY[1]);
  buf B_CFGLINKCONTROLCOMMONCLOCK (CFGLINKCONTROLCOMMONCLOCK, CFGLINKCONTROLCOMMONCLOCK_OUTDELAY);
  buf B_CFGLINKCONTROLEXTENDEDSYNC (CFGLINKCONTROLEXTENDEDSYNC, CFGLINKCONTROLEXTENDEDSYNC_OUTDELAY);
  buf B_CFGLTSSMSTATE0 (CFGLTSSMSTATE[0], CFGLTSSMSTATE_OUTDELAY[0]);
  buf B_CFGLTSSMSTATE1 (CFGLTSSMSTATE[1], CFGLTSSMSTATE_OUTDELAY[1]);
  buf B_CFGLTSSMSTATE2 (CFGLTSSMSTATE[2], CFGLTSSMSTATE_OUTDELAY[2]);
  buf B_CFGLTSSMSTATE3 (CFGLTSSMSTATE[3], CFGLTSSMSTATE_OUTDELAY[3]);
  buf B_CFGLTSSMSTATE4 (CFGLTSSMSTATE[4], CFGLTSSMSTATE_OUTDELAY[4]);
  buf B_CFGPCIELINKSTATEN0 (CFGPCIELINKSTATEN[0], CFGPCIELINKSTATEN_OUTDELAY[0]);
  buf B_CFGPCIELINKSTATEN1 (CFGPCIELINKSTATEN[1], CFGPCIELINKSTATEN_OUTDELAY[1]);
  buf B_CFGPCIELINKSTATEN2 (CFGPCIELINKSTATEN[2], CFGPCIELINKSTATEN_OUTDELAY[2]);
  buf B_CFGRDWRDONEN (CFGRDWRDONEN, CFGRDWRDONEN_OUTDELAY);
  buf B_CFGTOTURNOFFN (CFGTOTURNOFFN, CFGTOTURNOFFN_OUTDELAY);
  buf B_DBGBADDLLPSTATUS (DBGBADDLLPSTATUS, DBGBADDLLPSTATUS_OUTDELAY);
  buf B_DBGBADTLPLCRC (DBGBADTLPLCRC, DBGBADTLPLCRC_OUTDELAY);
  buf B_DBGBADTLPSEQNUM (DBGBADTLPSEQNUM, DBGBADTLPSEQNUM_OUTDELAY);
  buf B_DBGBADTLPSTATUS (DBGBADTLPSTATUS, DBGBADTLPSTATUS_OUTDELAY);
  buf B_DBGDLPROTOCOLSTATUS (DBGDLPROTOCOLSTATUS, DBGDLPROTOCOLSTATUS_OUTDELAY);
  buf B_DBGFCPROTOCOLERRSTATUS (DBGFCPROTOCOLERRSTATUS, DBGFCPROTOCOLERRSTATUS_OUTDELAY);
  buf B_DBGMLFRMDLENGTH (DBGMLFRMDLENGTH, DBGMLFRMDLENGTH_OUTDELAY);
  buf B_DBGMLFRMDMPS (DBGMLFRMDMPS, DBGMLFRMDMPS_OUTDELAY);
  buf B_DBGMLFRMDTCVC (DBGMLFRMDTCVC, DBGMLFRMDTCVC_OUTDELAY);
  buf B_DBGMLFRMDTLPSTATUS (DBGMLFRMDTLPSTATUS, DBGMLFRMDTLPSTATUS_OUTDELAY);
  buf B_DBGMLFRMDUNRECTYPE (DBGMLFRMDUNRECTYPE, DBGMLFRMDUNRECTYPE_OUTDELAY);
  buf B_DBGPOISTLPSTATUS (DBGPOISTLPSTATUS, DBGPOISTLPSTATUS_OUTDELAY);
  buf B_DBGRCVROVERFLOWSTATUS (DBGRCVROVERFLOWSTATUS, DBGRCVROVERFLOWSTATUS_OUTDELAY);
  buf B_DBGREGDETECTEDCORRECTABLE (DBGREGDETECTEDCORRECTABLE, DBGREGDETECTEDCORRECTABLE_OUTDELAY);
  buf B_DBGREGDETECTEDFATAL (DBGREGDETECTEDFATAL, DBGREGDETECTEDFATAL_OUTDELAY);
  buf B_DBGREGDETECTEDNONFATAL (DBGREGDETECTEDNONFATAL, DBGREGDETECTEDNONFATAL_OUTDELAY);
  buf B_DBGREGDETECTEDUNSUPPORTED (DBGREGDETECTEDUNSUPPORTED, DBGREGDETECTEDUNSUPPORTED_OUTDELAY);
  buf B_DBGRPLYROLLOVERSTATUS (DBGRPLYROLLOVERSTATUS, DBGRPLYROLLOVERSTATUS_OUTDELAY);
  buf B_DBGRPLYTIMEOUTSTATUS (DBGRPLYTIMEOUTSTATUS, DBGRPLYTIMEOUTSTATUS_OUTDELAY);
  buf B_DBGURNOBARHIT (DBGURNOBARHIT, DBGURNOBARHIT_OUTDELAY);
  buf B_DBGURPOISCFGWR (DBGURPOISCFGWR, DBGURPOISCFGWR_OUTDELAY);
  buf B_DBGURSTATUS (DBGURSTATUS, DBGURSTATUS_OUTDELAY);
  buf B_DBGURUNSUPMSG (DBGURUNSUPMSG, DBGURUNSUPMSG_OUTDELAY);
  buf B_MIMRXRADDR0 (MIMRXRADDR[0], MIMRXRADDR_OUTDELAY[0]);
  buf B_MIMRXRADDR1 (MIMRXRADDR[1], MIMRXRADDR_OUTDELAY[1]);
  buf B_MIMRXRADDR10 (MIMRXRADDR[10], MIMRXRADDR_OUTDELAY[10]);
  buf B_MIMRXRADDR11 (MIMRXRADDR[11], MIMRXRADDR_OUTDELAY[11]);
  buf B_MIMRXRADDR2 (MIMRXRADDR[2], MIMRXRADDR_OUTDELAY[2]);
  buf B_MIMRXRADDR3 (MIMRXRADDR[3], MIMRXRADDR_OUTDELAY[3]);
  buf B_MIMRXRADDR4 (MIMRXRADDR[4], MIMRXRADDR_OUTDELAY[4]);
  buf B_MIMRXRADDR5 (MIMRXRADDR[5], MIMRXRADDR_OUTDELAY[5]);
  buf B_MIMRXRADDR6 (MIMRXRADDR[6], MIMRXRADDR_OUTDELAY[6]);
  buf B_MIMRXRADDR7 (MIMRXRADDR[7], MIMRXRADDR_OUTDELAY[7]);
  buf B_MIMRXRADDR8 (MIMRXRADDR[8], MIMRXRADDR_OUTDELAY[8]);
  buf B_MIMRXRADDR9 (MIMRXRADDR[9], MIMRXRADDR_OUTDELAY[9]);
  buf B_MIMRXREN (MIMRXREN, MIMRXREN_OUTDELAY);
  buf B_MIMRXWADDR0 (MIMRXWADDR[0], MIMRXWADDR_OUTDELAY[0]);
  buf B_MIMRXWADDR1 (MIMRXWADDR[1], MIMRXWADDR_OUTDELAY[1]);
  buf B_MIMRXWADDR10 (MIMRXWADDR[10], MIMRXWADDR_OUTDELAY[10]);
  buf B_MIMRXWADDR11 (MIMRXWADDR[11], MIMRXWADDR_OUTDELAY[11]);
  buf B_MIMRXWADDR2 (MIMRXWADDR[2], MIMRXWADDR_OUTDELAY[2]);
  buf B_MIMRXWADDR3 (MIMRXWADDR[3], MIMRXWADDR_OUTDELAY[3]);
  buf B_MIMRXWADDR4 (MIMRXWADDR[4], MIMRXWADDR_OUTDELAY[4]);
  buf B_MIMRXWADDR5 (MIMRXWADDR[5], MIMRXWADDR_OUTDELAY[5]);
  buf B_MIMRXWADDR6 (MIMRXWADDR[6], MIMRXWADDR_OUTDELAY[6]);
  buf B_MIMRXWADDR7 (MIMRXWADDR[7], MIMRXWADDR_OUTDELAY[7]);
  buf B_MIMRXWADDR8 (MIMRXWADDR[8], MIMRXWADDR_OUTDELAY[8]);
  buf B_MIMRXWADDR9 (MIMRXWADDR[9], MIMRXWADDR_OUTDELAY[9]);
  buf B_MIMRXWDATA0 (MIMRXWDATA[0], MIMRXWDATA_OUTDELAY[0]);
  buf B_MIMRXWDATA1 (MIMRXWDATA[1], MIMRXWDATA_OUTDELAY[1]);
  buf B_MIMRXWDATA10 (MIMRXWDATA[10], MIMRXWDATA_OUTDELAY[10]);
  buf B_MIMRXWDATA11 (MIMRXWDATA[11], MIMRXWDATA_OUTDELAY[11]);
  buf B_MIMRXWDATA12 (MIMRXWDATA[12], MIMRXWDATA_OUTDELAY[12]);
  buf B_MIMRXWDATA13 (MIMRXWDATA[13], MIMRXWDATA_OUTDELAY[13]);
  buf B_MIMRXWDATA14 (MIMRXWDATA[14], MIMRXWDATA_OUTDELAY[14]);
  buf B_MIMRXWDATA15 (MIMRXWDATA[15], MIMRXWDATA_OUTDELAY[15]);
  buf B_MIMRXWDATA16 (MIMRXWDATA[16], MIMRXWDATA_OUTDELAY[16]);
  buf B_MIMRXWDATA17 (MIMRXWDATA[17], MIMRXWDATA_OUTDELAY[17]);
  buf B_MIMRXWDATA18 (MIMRXWDATA[18], MIMRXWDATA_OUTDELAY[18]);
  buf B_MIMRXWDATA19 (MIMRXWDATA[19], MIMRXWDATA_OUTDELAY[19]);
  buf B_MIMRXWDATA2 (MIMRXWDATA[2], MIMRXWDATA_OUTDELAY[2]);
  buf B_MIMRXWDATA20 (MIMRXWDATA[20], MIMRXWDATA_OUTDELAY[20]);
  buf B_MIMRXWDATA21 (MIMRXWDATA[21], MIMRXWDATA_OUTDELAY[21]);
  buf B_MIMRXWDATA22 (MIMRXWDATA[22], MIMRXWDATA_OUTDELAY[22]);
  buf B_MIMRXWDATA23 (MIMRXWDATA[23], MIMRXWDATA_OUTDELAY[23]);
  buf B_MIMRXWDATA24 (MIMRXWDATA[24], MIMRXWDATA_OUTDELAY[24]);
  buf B_MIMRXWDATA25 (MIMRXWDATA[25], MIMRXWDATA_OUTDELAY[25]);
  buf B_MIMRXWDATA26 (MIMRXWDATA[26], MIMRXWDATA_OUTDELAY[26]);
  buf B_MIMRXWDATA27 (MIMRXWDATA[27], MIMRXWDATA_OUTDELAY[27]);
  buf B_MIMRXWDATA28 (MIMRXWDATA[28], MIMRXWDATA_OUTDELAY[28]);
  buf B_MIMRXWDATA29 (MIMRXWDATA[29], MIMRXWDATA_OUTDELAY[29]);
  buf B_MIMRXWDATA3 (MIMRXWDATA[3], MIMRXWDATA_OUTDELAY[3]);
  buf B_MIMRXWDATA30 (MIMRXWDATA[30], MIMRXWDATA_OUTDELAY[30]);
  buf B_MIMRXWDATA31 (MIMRXWDATA[31], MIMRXWDATA_OUTDELAY[31]);
  buf B_MIMRXWDATA32 (MIMRXWDATA[32], MIMRXWDATA_OUTDELAY[32]);
  buf B_MIMRXWDATA33 (MIMRXWDATA[33], MIMRXWDATA_OUTDELAY[33]);
  buf B_MIMRXWDATA34 (MIMRXWDATA[34], MIMRXWDATA_OUTDELAY[34]);
  buf B_MIMRXWDATA4 (MIMRXWDATA[4], MIMRXWDATA_OUTDELAY[4]);
  buf B_MIMRXWDATA5 (MIMRXWDATA[5], MIMRXWDATA_OUTDELAY[5]);
  buf B_MIMRXWDATA6 (MIMRXWDATA[6], MIMRXWDATA_OUTDELAY[6]);
  buf B_MIMRXWDATA7 (MIMRXWDATA[7], MIMRXWDATA_OUTDELAY[7]);
  buf B_MIMRXWDATA8 (MIMRXWDATA[8], MIMRXWDATA_OUTDELAY[8]);
  buf B_MIMRXWDATA9 (MIMRXWDATA[9], MIMRXWDATA_OUTDELAY[9]);
  buf B_MIMRXWEN (MIMRXWEN, MIMRXWEN_OUTDELAY);
  buf B_MIMTXRADDR0 (MIMTXRADDR[0], MIMTXRADDR_OUTDELAY[0]);
  buf B_MIMTXRADDR1 (MIMTXRADDR[1], MIMTXRADDR_OUTDELAY[1]);
  buf B_MIMTXRADDR10 (MIMTXRADDR[10], MIMTXRADDR_OUTDELAY[10]);
  buf B_MIMTXRADDR11 (MIMTXRADDR[11], MIMTXRADDR_OUTDELAY[11]);
  buf B_MIMTXRADDR2 (MIMTXRADDR[2], MIMTXRADDR_OUTDELAY[2]);
  buf B_MIMTXRADDR3 (MIMTXRADDR[3], MIMTXRADDR_OUTDELAY[3]);
  buf B_MIMTXRADDR4 (MIMTXRADDR[4], MIMTXRADDR_OUTDELAY[4]);
  buf B_MIMTXRADDR5 (MIMTXRADDR[5], MIMTXRADDR_OUTDELAY[5]);
  buf B_MIMTXRADDR6 (MIMTXRADDR[6], MIMTXRADDR_OUTDELAY[6]);
  buf B_MIMTXRADDR7 (MIMTXRADDR[7], MIMTXRADDR_OUTDELAY[7]);
  buf B_MIMTXRADDR8 (MIMTXRADDR[8], MIMTXRADDR_OUTDELAY[8]);
  buf B_MIMTXRADDR9 (MIMTXRADDR[9], MIMTXRADDR_OUTDELAY[9]);
  buf B_MIMTXREN (MIMTXREN, MIMTXREN_OUTDELAY);
  buf B_MIMTXWADDR0 (MIMTXWADDR[0], MIMTXWADDR_OUTDELAY[0]);
  buf B_MIMTXWADDR1 (MIMTXWADDR[1], MIMTXWADDR_OUTDELAY[1]);
  buf B_MIMTXWADDR10 (MIMTXWADDR[10], MIMTXWADDR_OUTDELAY[10]);
  buf B_MIMTXWADDR11 (MIMTXWADDR[11], MIMTXWADDR_OUTDELAY[11]);
  buf B_MIMTXWADDR2 (MIMTXWADDR[2], MIMTXWADDR_OUTDELAY[2]);
  buf B_MIMTXWADDR3 (MIMTXWADDR[3], MIMTXWADDR_OUTDELAY[3]);
  buf B_MIMTXWADDR4 (MIMTXWADDR[4], MIMTXWADDR_OUTDELAY[4]);
  buf B_MIMTXWADDR5 (MIMTXWADDR[5], MIMTXWADDR_OUTDELAY[5]);
  buf B_MIMTXWADDR6 (MIMTXWADDR[6], MIMTXWADDR_OUTDELAY[6]);
  buf B_MIMTXWADDR7 (MIMTXWADDR[7], MIMTXWADDR_OUTDELAY[7]);
  buf B_MIMTXWADDR8 (MIMTXWADDR[8], MIMTXWADDR_OUTDELAY[8]);
  buf B_MIMTXWADDR9 (MIMTXWADDR[9], MIMTXWADDR_OUTDELAY[9]);
  buf B_MIMTXWDATA0 (MIMTXWDATA[0], MIMTXWDATA_OUTDELAY[0]);
  buf B_MIMTXWDATA1 (MIMTXWDATA[1], MIMTXWDATA_OUTDELAY[1]);
  buf B_MIMTXWDATA10 (MIMTXWDATA[10], MIMTXWDATA_OUTDELAY[10]);
  buf B_MIMTXWDATA11 (MIMTXWDATA[11], MIMTXWDATA_OUTDELAY[11]);
  buf B_MIMTXWDATA12 (MIMTXWDATA[12], MIMTXWDATA_OUTDELAY[12]);
  buf B_MIMTXWDATA13 (MIMTXWDATA[13], MIMTXWDATA_OUTDELAY[13]);
  buf B_MIMTXWDATA14 (MIMTXWDATA[14], MIMTXWDATA_OUTDELAY[14]);
  buf B_MIMTXWDATA15 (MIMTXWDATA[15], MIMTXWDATA_OUTDELAY[15]);
  buf B_MIMTXWDATA16 (MIMTXWDATA[16], MIMTXWDATA_OUTDELAY[16]);
  buf B_MIMTXWDATA17 (MIMTXWDATA[17], MIMTXWDATA_OUTDELAY[17]);
  buf B_MIMTXWDATA18 (MIMTXWDATA[18], MIMTXWDATA_OUTDELAY[18]);
  buf B_MIMTXWDATA19 (MIMTXWDATA[19], MIMTXWDATA_OUTDELAY[19]);
  buf B_MIMTXWDATA2 (MIMTXWDATA[2], MIMTXWDATA_OUTDELAY[2]);
  buf B_MIMTXWDATA20 (MIMTXWDATA[20], MIMTXWDATA_OUTDELAY[20]);
  buf B_MIMTXWDATA21 (MIMTXWDATA[21], MIMTXWDATA_OUTDELAY[21]);
  buf B_MIMTXWDATA22 (MIMTXWDATA[22], MIMTXWDATA_OUTDELAY[22]);
  buf B_MIMTXWDATA23 (MIMTXWDATA[23], MIMTXWDATA_OUTDELAY[23]);
  buf B_MIMTXWDATA24 (MIMTXWDATA[24], MIMTXWDATA_OUTDELAY[24]);
  buf B_MIMTXWDATA25 (MIMTXWDATA[25], MIMTXWDATA_OUTDELAY[25]);
  buf B_MIMTXWDATA26 (MIMTXWDATA[26], MIMTXWDATA_OUTDELAY[26]);
  buf B_MIMTXWDATA27 (MIMTXWDATA[27], MIMTXWDATA_OUTDELAY[27]);
  buf B_MIMTXWDATA28 (MIMTXWDATA[28], MIMTXWDATA_OUTDELAY[28]);
  buf B_MIMTXWDATA29 (MIMTXWDATA[29], MIMTXWDATA_OUTDELAY[29]);
  buf B_MIMTXWDATA3 (MIMTXWDATA[3], MIMTXWDATA_OUTDELAY[3]);
  buf B_MIMTXWDATA30 (MIMTXWDATA[30], MIMTXWDATA_OUTDELAY[30]);
  buf B_MIMTXWDATA31 (MIMTXWDATA[31], MIMTXWDATA_OUTDELAY[31]);
  buf B_MIMTXWDATA32 (MIMTXWDATA[32], MIMTXWDATA_OUTDELAY[32]);
  buf B_MIMTXWDATA33 (MIMTXWDATA[33], MIMTXWDATA_OUTDELAY[33]);
  buf B_MIMTXWDATA34 (MIMTXWDATA[34], MIMTXWDATA_OUTDELAY[34]);
  buf B_MIMTXWDATA35 (MIMTXWDATA[35], MIMTXWDATA_OUTDELAY[35]);
  buf B_MIMTXWDATA4 (MIMTXWDATA[4], MIMTXWDATA_OUTDELAY[4]);
  buf B_MIMTXWDATA5 (MIMTXWDATA[5], MIMTXWDATA_OUTDELAY[5]);
  buf B_MIMTXWDATA6 (MIMTXWDATA[6], MIMTXWDATA_OUTDELAY[6]);
  buf B_MIMTXWDATA7 (MIMTXWDATA[7], MIMTXWDATA_OUTDELAY[7]);
  buf B_MIMTXWDATA8 (MIMTXWDATA[8], MIMTXWDATA_OUTDELAY[8]);
  buf B_MIMTXWDATA9 (MIMTXWDATA[9], MIMTXWDATA_OUTDELAY[9]);
  buf B_MIMTXWEN (MIMTXWEN, MIMTXWEN_OUTDELAY);
  buf B_PIPEGTPOWERDOWNA0 (PIPEGTPOWERDOWNA[0], PIPEGTPOWERDOWNA_OUTDELAY[0]);
  buf B_PIPEGTPOWERDOWNA1 (PIPEGTPOWERDOWNA[1], PIPEGTPOWERDOWNA_OUTDELAY[1]);
  buf B_PIPEGTPOWERDOWNB0 (PIPEGTPOWERDOWNB[0], PIPEGTPOWERDOWNB_OUTDELAY[0]);
  buf B_PIPEGTPOWERDOWNB1 (PIPEGTPOWERDOWNB[1], PIPEGTPOWERDOWNB_OUTDELAY[1]);
  buf B_PIPEGTTXELECIDLEA (PIPEGTTXELECIDLEA, PIPEGTTXELECIDLEA_OUTDELAY);
  buf B_PIPEGTTXELECIDLEB (PIPEGTTXELECIDLEB, PIPEGTTXELECIDLEB_OUTDELAY);
  buf B_PIPERXPOLARITYA (PIPERXPOLARITYA, PIPERXPOLARITYA_OUTDELAY);
  buf B_PIPERXPOLARITYB (PIPERXPOLARITYB, PIPERXPOLARITYB_OUTDELAY);
  buf B_PIPERXRESETA (PIPERXRESETA, PIPERXRESETA_OUTDELAY);
  buf B_PIPERXRESETB (PIPERXRESETB, PIPERXRESETB_OUTDELAY);
  buf B_PIPETXCHARDISPMODEA0 (PIPETXCHARDISPMODEA[0], PIPETXCHARDISPMODEA_OUTDELAY[0]);
  buf B_PIPETXCHARDISPMODEA1 (PIPETXCHARDISPMODEA[1], PIPETXCHARDISPMODEA_OUTDELAY[1]);
  buf B_PIPETXCHARDISPMODEB0 (PIPETXCHARDISPMODEB[0], PIPETXCHARDISPMODEB_OUTDELAY[0]);
  buf B_PIPETXCHARDISPMODEB1 (PIPETXCHARDISPMODEB[1], PIPETXCHARDISPMODEB_OUTDELAY[1]);
  buf B_PIPETXCHARDISPVALA0 (PIPETXCHARDISPVALA[0], PIPETXCHARDISPVALA_OUTDELAY[0]);
  buf B_PIPETXCHARDISPVALA1 (PIPETXCHARDISPVALA[1], PIPETXCHARDISPVALA_OUTDELAY[1]);
  buf B_PIPETXCHARDISPVALB0 (PIPETXCHARDISPVALB[0], PIPETXCHARDISPVALB_OUTDELAY[0]);
  buf B_PIPETXCHARDISPVALB1 (PIPETXCHARDISPVALB[1], PIPETXCHARDISPVALB_OUTDELAY[1]);
  buf B_PIPETXCHARISKA0 (PIPETXCHARISKA[0], PIPETXCHARISKA_OUTDELAY[0]);
  buf B_PIPETXCHARISKA1 (PIPETXCHARISKA[1], PIPETXCHARISKA_OUTDELAY[1]);
  buf B_PIPETXCHARISKB0 (PIPETXCHARISKB[0], PIPETXCHARISKB_OUTDELAY[0]);
  buf B_PIPETXCHARISKB1 (PIPETXCHARISKB[1], PIPETXCHARISKB_OUTDELAY[1]);
  buf B_PIPETXDATAA0 (PIPETXDATAA[0], PIPETXDATAA_OUTDELAY[0]);
  buf B_PIPETXDATAA1 (PIPETXDATAA[1], PIPETXDATAA_OUTDELAY[1]);
  buf B_PIPETXDATAA10 (PIPETXDATAA[10], PIPETXDATAA_OUTDELAY[10]);
  buf B_PIPETXDATAA11 (PIPETXDATAA[11], PIPETXDATAA_OUTDELAY[11]);
  buf B_PIPETXDATAA12 (PIPETXDATAA[12], PIPETXDATAA_OUTDELAY[12]);
  buf B_PIPETXDATAA13 (PIPETXDATAA[13], PIPETXDATAA_OUTDELAY[13]);
  buf B_PIPETXDATAA14 (PIPETXDATAA[14], PIPETXDATAA_OUTDELAY[14]);
  buf B_PIPETXDATAA15 (PIPETXDATAA[15], PIPETXDATAA_OUTDELAY[15]);
  buf B_PIPETXDATAA2 (PIPETXDATAA[2], PIPETXDATAA_OUTDELAY[2]);
  buf B_PIPETXDATAA3 (PIPETXDATAA[3], PIPETXDATAA_OUTDELAY[3]);
  buf B_PIPETXDATAA4 (PIPETXDATAA[4], PIPETXDATAA_OUTDELAY[4]);
  buf B_PIPETXDATAA5 (PIPETXDATAA[5], PIPETXDATAA_OUTDELAY[5]);
  buf B_PIPETXDATAA6 (PIPETXDATAA[6], PIPETXDATAA_OUTDELAY[6]);
  buf B_PIPETXDATAA7 (PIPETXDATAA[7], PIPETXDATAA_OUTDELAY[7]);
  buf B_PIPETXDATAA8 (PIPETXDATAA[8], PIPETXDATAA_OUTDELAY[8]);
  buf B_PIPETXDATAA9 (PIPETXDATAA[9], PIPETXDATAA_OUTDELAY[9]);
  buf B_PIPETXDATAB0 (PIPETXDATAB[0], PIPETXDATAB_OUTDELAY[0]);
  buf B_PIPETXDATAB1 (PIPETXDATAB[1], PIPETXDATAB_OUTDELAY[1]);
  buf B_PIPETXDATAB10 (PIPETXDATAB[10], PIPETXDATAB_OUTDELAY[10]);
  buf B_PIPETXDATAB11 (PIPETXDATAB[11], PIPETXDATAB_OUTDELAY[11]);
  buf B_PIPETXDATAB12 (PIPETXDATAB[12], PIPETXDATAB_OUTDELAY[12]);
  buf B_PIPETXDATAB13 (PIPETXDATAB[13], PIPETXDATAB_OUTDELAY[13]);
  buf B_PIPETXDATAB14 (PIPETXDATAB[14], PIPETXDATAB_OUTDELAY[14]);
  buf B_PIPETXDATAB15 (PIPETXDATAB[15], PIPETXDATAB_OUTDELAY[15]);
  buf B_PIPETXDATAB2 (PIPETXDATAB[2], PIPETXDATAB_OUTDELAY[2]);
  buf B_PIPETXDATAB3 (PIPETXDATAB[3], PIPETXDATAB_OUTDELAY[3]);
  buf B_PIPETXDATAB4 (PIPETXDATAB[4], PIPETXDATAB_OUTDELAY[4]);
  buf B_PIPETXDATAB5 (PIPETXDATAB[5], PIPETXDATAB_OUTDELAY[5]);
  buf B_PIPETXDATAB6 (PIPETXDATAB[6], PIPETXDATAB_OUTDELAY[6]);
  buf B_PIPETXDATAB7 (PIPETXDATAB[7], PIPETXDATAB_OUTDELAY[7]);
  buf B_PIPETXDATAB8 (PIPETXDATAB[8], PIPETXDATAB_OUTDELAY[8]);
  buf B_PIPETXDATAB9 (PIPETXDATAB[9], PIPETXDATAB_OUTDELAY[9]);
  buf B_PIPETXRCVRDETA (PIPETXRCVRDETA, PIPETXRCVRDETA_OUTDELAY);
  buf B_PIPETXRCVRDETB (PIPETXRCVRDETB, PIPETXRCVRDETB_OUTDELAY);
  buf B_RECEIVEDHOTRESET (RECEIVEDHOTRESET, RECEIVEDHOTRESET_OUTDELAY);
  buf B_TRNFCCPLD0 (TRNFCCPLD[0], TRNFCCPLD_OUTDELAY[0]);
  buf B_TRNFCCPLD1 (TRNFCCPLD[1], TRNFCCPLD_OUTDELAY[1]);
  buf B_TRNFCCPLD10 (TRNFCCPLD[10], TRNFCCPLD_OUTDELAY[10]);
  buf B_TRNFCCPLD11 (TRNFCCPLD[11], TRNFCCPLD_OUTDELAY[11]);
  buf B_TRNFCCPLD2 (TRNFCCPLD[2], TRNFCCPLD_OUTDELAY[2]);
  buf B_TRNFCCPLD3 (TRNFCCPLD[3], TRNFCCPLD_OUTDELAY[3]);
  buf B_TRNFCCPLD4 (TRNFCCPLD[4], TRNFCCPLD_OUTDELAY[4]);
  buf B_TRNFCCPLD5 (TRNFCCPLD[5], TRNFCCPLD_OUTDELAY[5]);
  buf B_TRNFCCPLD6 (TRNFCCPLD[6], TRNFCCPLD_OUTDELAY[6]);
  buf B_TRNFCCPLD7 (TRNFCCPLD[7], TRNFCCPLD_OUTDELAY[7]);
  buf B_TRNFCCPLD8 (TRNFCCPLD[8], TRNFCCPLD_OUTDELAY[8]);
  buf B_TRNFCCPLD9 (TRNFCCPLD[9], TRNFCCPLD_OUTDELAY[9]);
  buf B_TRNFCCPLH0 (TRNFCCPLH[0], TRNFCCPLH_OUTDELAY[0]);
  buf B_TRNFCCPLH1 (TRNFCCPLH[1], TRNFCCPLH_OUTDELAY[1]);
  buf B_TRNFCCPLH2 (TRNFCCPLH[2], TRNFCCPLH_OUTDELAY[2]);
  buf B_TRNFCCPLH3 (TRNFCCPLH[3], TRNFCCPLH_OUTDELAY[3]);
  buf B_TRNFCCPLH4 (TRNFCCPLH[4], TRNFCCPLH_OUTDELAY[4]);
  buf B_TRNFCCPLH5 (TRNFCCPLH[5], TRNFCCPLH_OUTDELAY[5]);
  buf B_TRNFCCPLH6 (TRNFCCPLH[6], TRNFCCPLH_OUTDELAY[6]);
  buf B_TRNFCCPLH7 (TRNFCCPLH[7], TRNFCCPLH_OUTDELAY[7]);
  buf B_TRNFCNPD0 (TRNFCNPD[0], TRNFCNPD_OUTDELAY[0]);
  buf B_TRNFCNPD1 (TRNFCNPD[1], TRNFCNPD_OUTDELAY[1]);
  buf B_TRNFCNPD10 (TRNFCNPD[10], TRNFCNPD_OUTDELAY[10]);
  buf B_TRNFCNPD11 (TRNFCNPD[11], TRNFCNPD_OUTDELAY[11]);
  buf B_TRNFCNPD2 (TRNFCNPD[2], TRNFCNPD_OUTDELAY[2]);
  buf B_TRNFCNPD3 (TRNFCNPD[3], TRNFCNPD_OUTDELAY[3]);
  buf B_TRNFCNPD4 (TRNFCNPD[4], TRNFCNPD_OUTDELAY[4]);
  buf B_TRNFCNPD5 (TRNFCNPD[5], TRNFCNPD_OUTDELAY[5]);
  buf B_TRNFCNPD6 (TRNFCNPD[6], TRNFCNPD_OUTDELAY[6]);
  buf B_TRNFCNPD7 (TRNFCNPD[7], TRNFCNPD_OUTDELAY[7]);
  buf B_TRNFCNPD8 (TRNFCNPD[8], TRNFCNPD_OUTDELAY[8]);
  buf B_TRNFCNPD9 (TRNFCNPD[9], TRNFCNPD_OUTDELAY[9]);
  buf B_TRNFCNPH0 (TRNFCNPH[0], TRNFCNPH_OUTDELAY[0]);
  buf B_TRNFCNPH1 (TRNFCNPH[1], TRNFCNPH_OUTDELAY[1]);
  buf B_TRNFCNPH2 (TRNFCNPH[2], TRNFCNPH_OUTDELAY[2]);
  buf B_TRNFCNPH3 (TRNFCNPH[3], TRNFCNPH_OUTDELAY[3]);
  buf B_TRNFCNPH4 (TRNFCNPH[4], TRNFCNPH_OUTDELAY[4]);
  buf B_TRNFCNPH5 (TRNFCNPH[5], TRNFCNPH_OUTDELAY[5]);
  buf B_TRNFCNPH6 (TRNFCNPH[6], TRNFCNPH_OUTDELAY[6]);
  buf B_TRNFCNPH7 (TRNFCNPH[7], TRNFCNPH_OUTDELAY[7]);
  buf B_TRNFCPD0 (TRNFCPD[0], TRNFCPD_OUTDELAY[0]);
  buf B_TRNFCPD1 (TRNFCPD[1], TRNFCPD_OUTDELAY[1]);
  buf B_TRNFCPD10 (TRNFCPD[10], TRNFCPD_OUTDELAY[10]);
  buf B_TRNFCPD11 (TRNFCPD[11], TRNFCPD_OUTDELAY[11]);
  buf B_TRNFCPD2 (TRNFCPD[2], TRNFCPD_OUTDELAY[2]);
  buf B_TRNFCPD3 (TRNFCPD[3], TRNFCPD_OUTDELAY[3]);
  buf B_TRNFCPD4 (TRNFCPD[4], TRNFCPD_OUTDELAY[4]);
  buf B_TRNFCPD5 (TRNFCPD[5], TRNFCPD_OUTDELAY[5]);
  buf B_TRNFCPD6 (TRNFCPD[6], TRNFCPD_OUTDELAY[6]);
  buf B_TRNFCPD7 (TRNFCPD[7], TRNFCPD_OUTDELAY[7]);
  buf B_TRNFCPD8 (TRNFCPD[8], TRNFCPD_OUTDELAY[8]);
  buf B_TRNFCPD9 (TRNFCPD[9], TRNFCPD_OUTDELAY[9]);
  buf B_TRNFCPH0 (TRNFCPH[0], TRNFCPH_OUTDELAY[0]);
  buf B_TRNFCPH1 (TRNFCPH[1], TRNFCPH_OUTDELAY[1]);
  buf B_TRNFCPH2 (TRNFCPH[2], TRNFCPH_OUTDELAY[2]);
  buf B_TRNFCPH3 (TRNFCPH[3], TRNFCPH_OUTDELAY[3]);
  buf B_TRNFCPH4 (TRNFCPH[4], TRNFCPH_OUTDELAY[4]);
  buf B_TRNFCPH5 (TRNFCPH[5], TRNFCPH_OUTDELAY[5]);
  buf B_TRNFCPH6 (TRNFCPH[6], TRNFCPH_OUTDELAY[6]);
  buf B_TRNFCPH7 (TRNFCPH[7], TRNFCPH_OUTDELAY[7]);
  buf B_TRNLNKUPN (TRNLNKUPN, TRNLNKUPN_OUTDELAY);
  buf B_TRNRBARHITN0 (TRNRBARHITN[0], TRNRBARHITN_OUTDELAY[0]);
  buf B_TRNRBARHITN1 (TRNRBARHITN[1], TRNRBARHITN_OUTDELAY[1]);
  buf B_TRNRBARHITN2 (TRNRBARHITN[2], TRNRBARHITN_OUTDELAY[2]);
  buf B_TRNRBARHITN3 (TRNRBARHITN[3], TRNRBARHITN_OUTDELAY[3]);
  buf B_TRNRBARHITN4 (TRNRBARHITN[4], TRNRBARHITN_OUTDELAY[4]);
  buf B_TRNRBARHITN5 (TRNRBARHITN[5], TRNRBARHITN_OUTDELAY[5]);
  buf B_TRNRBARHITN6 (TRNRBARHITN[6], TRNRBARHITN_OUTDELAY[6]);
  buf B_TRNRD0 (TRNRD[0], TRNRD_OUTDELAY[0]);
  buf B_TRNRD1 (TRNRD[1], TRNRD_OUTDELAY[1]);
  buf B_TRNRD10 (TRNRD[10], TRNRD_OUTDELAY[10]);
  buf B_TRNRD11 (TRNRD[11], TRNRD_OUTDELAY[11]);
  buf B_TRNRD12 (TRNRD[12], TRNRD_OUTDELAY[12]);
  buf B_TRNRD13 (TRNRD[13], TRNRD_OUTDELAY[13]);
  buf B_TRNRD14 (TRNRD[14], TRNRD_OUTDELAY[14]);
  buf B_TRNRD15 (TRNRD[15], TRNRD_OUTDELAY[15]);
  buf B_TRNRD16 (TRNRD[16], TRNRD_OUTDELAY[16]);
  buf B_TRNRD17 (TRNRD[17], TRNRD_OUTDELAY[17]);
  buf B_TRNRD18 (TRNRD[18], TRNRD_OUTDELAY[18]);
  buf B_TRNRD19 (TRNRD[19], TRNRD_OUTDELAY[19]);
  buf B_TRNRD2 (TRNRD[2], TRNRD_OUTDELAY[2]);
  buf B_TRNRD20 (TRNRD[20], TRNRD_OUTDELAY[20]);
  buf B_TRNRD21 (TRNRD[21], TRNRD_OUTDELAY[21]);
  buf B_TRNRD22 (TRNRD[22], TRNRD_OUTDELAY[22]);
  buf B_TRNRD23 (TRNRD[23], TRNRD_OUTDELAY[23]);
  buf B_TRNRD24 (TRNRD[24], TRNRD_OUTDELAY[24]);
  buf B_TRNRD25 (TRNRD[25], TRNRD_OUTDELAY[25]);
  buf B_TRNRD26 (TRNRD[26], TRNRD_OUTDELAY[26]);
  buf B_TRNRD27 (TRNRD[27], TRNRD_OUTDELAY[27]);
  buf B_TRNRD28 (TRNRD[28], TRNRD_OUTDELAY[28]);
  buf B_TRNRD29 (TRNRD[29], TRNRD_OUTDELAY[29]);
  buf B_TRNRD3 (TRNRD[3], TRNRD_OUTDELAY[3]);
  buf B_TRNRD30 (TRNRD[30], TRNRD_OUTDELAY[30]);
  buf B_TRNRD31 (TRNRD[31], TRNRD_OUTDELAY[31]);
  buf B_TRNRD4 (TRNRD[4], TRNRD_OUTDELAY[4]);
  buf B_TRNRD5 (TRNRD[5], TRNRD_OUTDELAY[5]);
  buf B_TRNRD6 (TRNRD[6], TRNRD_OUTDELAY[6]);
  buf B_TRNRD7 (TRNRD[7], TRNRD_OUTDELAY[7]);
  buf B_TRNRD8 (TRNRD[8], TRNRD_OUTDELAY[8]);
  buf B_TRNRD9 (TRNRD[9], TRNRD_OUTDELAY[9]);
  buf B_TRNREOFN (TRNREOFN, TRNREOFN_OUTDELAY);
  buf B_TRNRERRFWDN (TRNRERRFWDN, TRNRERRFWDN_OUTDELAY);
  buf B_TRNRSOFN (TRNRSOFN, TRNRSOFN_OUTDELAY);
  buf B_TRNRSRCDSCN (TRNRSRCDSCN, TRNRSRCDSCN_OUTDELAY);
  buf B_TRNRSRCRDYN (TRNRSRCRDYN, TRNRSRCRDYN_OUTDELAY);
  buf B_TRNTBUFAV0 (TRNTBUFAV[0], TRNTBUFAV_OUTDELAY[0]);
  buf B_TRNTBUFAV1 (TRNTBUFAV[1], TRNTBUFAV_OUTDELAY[1]);
  buf B_TRNTBUFAV2 (TRNTBUFAV[2], TRNTBUFAV_OUTDELAY[2]);
  buf B_TRNTBUFAV3 (TRNTBUFAV[3], TRNTBUFAV_OUTDELAY[3]);
  buf B_TRNTBUFAV4 (TRNTBUFAV[4], TRNTBUFAV_OUTDELAY[4]);
  buf B_TRNTBUFAV5 (TRNTBUFAV[5], TRNTBUFAV_OUTDELAY[5]);
  buf B_TRNTCFGREQN (TRNTCFGREQN, TRNTCFGREQN_OUTDELAY);
  buf B_TRNTDSTRDYN (TRNTDSTRDYN, TRNTDSTRDYN_OUTDELAY);
  buf B_TRNTERRDROPN (TRNTERRDROPN, TRNTERRDROPN_OUTDELAY);
  buf B_USERRSTN (USERRSTN, USERRSTN_OUTDELAY);

  buf B_CFGDEVID0 (CFGDEVID_IN[0], CFGDEVID[0]);
  buf B_CFGDEVID1 (CFGDEVID_IN[1], CFGDEVID[1]);
  buf B_CFGDEVID10 (CFGDEVID_IN[10], CFGDEVID[10]);
  buf B_CFGDEVID11 (CFGDEVID_IN[11], CFGDEVID[11]);
  buf B_CFGDEVID12 (CFGDEVID_IN[12], CFGDEVID[12]);
  buf B_CFGDEVID13 (CFGDEVID_IN[13], CFGDEVID[13]);
  buf B_CFGDEVID14 (CFGDEVID_IN[14], CFGDEVID[14]);
  buf B_CFGDEVID15 (CFGDEVID_IN[15], CFGDEVID[15]);
  buf B_CFGDEVID2 (CFGDEVID_IN[2], CFGDEVID[2]);
  buf B_CFGDEVID3 (CFGDEVID_IN[3], CFGDEVID[3]);
  buf B_CFGDEVID4 (CFGDEVID_IN[4], CFGDEVID[4]);
  buf B_CFGDEVID5 (CFGDEVID_IN[5], CFGDEVID[5]);
  buf B_CFGDEVID6 (CFGDEVID_IN[6], CFGDEVID[6]);
  buf B_CFGDEVID7 (CFGDEVID_IN[7], CFGDEVID[7]);
  buf B_CFGDEVID8 (CFGDEVID_IN[8], CFGDEVID[8]);
  buf B_CFGDEVID9 (CFGDEVID_IN[9], CFGDEVID[9]);
  buf B_CFGDSN0 (CFGDSN_IN[0], CFGDSN[0]);
  buf B_CFGDSN1 (CFGDSN_IN[1], CFGDSN[1]);
  buf B_CFGDSN10 (CFGDSN_IN[10], CFGDSN[10]);
  buf B_CFGDSN11 (CFGDSN_IN[11], CFGDSN[11]);
  buf B_CFGDSN12 (CFGDSN_IN[12], CFGDSN[12]);
  buf B_CFGDSN13 (CFGDSN_IN[13], CFGDSN[13]);
  buf B_CFGDSN14 (CFGDSN_IN[14], CFGDSN[14]);
  buf B_CFGDSN15 (CFGDSN_IN[15], CFGDSN[15]);
  buf B_CFGDSN16 (CFGDSN_IN[16], CFGDSN[16]);
  buf B_CFGDSN17 (CFGDSN_IN[17], CFGDSN[17]);
  buf B_CFGDSN18 (CFGDSN_IN[18], CFGDSN[18]);
  buf B_CFGDSN19 (CFGDSN_IN[19], CFGDSN[19]);
  buf B_CFGDSN2 (CFGDSN_IN[2], CFGDSN[2]);
  buf B_CFGDSN20 (CFGDSN_IN[20], CFGDSN[20]);
  buf B_CFGDSN21 (CFGDSN_IN[21], CFGDSN[21]);
  buf B_CFGDSN22 (CFGDSN_IN[22], CFGDSN[22]);
  buf B_CFGDSN23 (CFGDSN_IN[23], CFGDSN[23]);
  buf B_CFGDSN24 (CFGDSN_IN[24], CFGDSN[24]);
  buf B_CFGDSN25 (CFGDSN_IN[25], CFGDSN[25]);
  buf B_CFGDSN26 (CFGDSN_IN[26], CFGDSN[26]);
  buf B_CFGDSN27 (CFGDSN_IN[27], CFGDSN[27]);
  buf B_CFGDSN28 (CFGDSN_IN[28], CFGDSN[28]);
  buf B_CFGDSN29 (CFGDSN_IN[29], CFGDSN[29]);
  buf B_CFGDSN3 (CFGDSN_IN[3], CFGDSN[3]);
  buf B_CFGDSN30 (CFGDSN_IN[30], CFGDSN[30]);
  buf B_CFGDSN31 (CFGDSN_IN[31], CFGDSN[31]);
  buf B_CFGDSN32 (CFGDSN_IN[32], CFGDSN[32]);
  buf B_CFGDSN33 (CFGDSN_IN[33], CFGDSN[33]);
  buf B_CFGDSN34 (CFGDSN_IN[34], CFGDSN[34]);
  buf B_CFGDSN35 (CFGDSN_IN[35], CFGDSN[35]);
  buf B_CFGDSN36 (CFGDSN_IN[36], CFGDSN[36]);
  buf B_CFGDSN37 (CFGDSN_IN[37], CFGDSN[37]);
  buf B_CFGDSN38 (CFGDSN_IN[38], CFGDSN[38]);
  buf B_CFGDSN39 (CFGDSN_IN[39], CFGDSN[39]);
  buf B_CFGDSN4 (CFGDSN_IN[4], CFGDSN[4]);
  buf B_CFGDSN40 (CFGDSN_IN[40], CFGDSN[40]);
  buf B_CFGDSN41 (CFGDSN_IN[41], CFGDSN[41]);
  buf B_CFGDSN42 (CFGDSN_IN[42], CFGDSN[42]);
  buf B_CFGDSN43 (CFGDSN_IN[43], CFGDSN[43]);
  buf B_CFGDSN44 (CFGDSN_IN[44], CFGDSN[44]);
  buf B_CFGDSN45 (CFGDSN_IN[45], CFGDSN[45]);
  buf B_CFGDSN46 (CFGDSN_IN[46], CFGDSN[46]);
  buf B_CFGDSN47 (CFGDSN_IN[47], CFGDSN[47]);
  buf B_CFGDSN48 (CFGDSN_IN[48], CFGDSN[48]);
  buf B_CFGDSN49 (CFGDSN_IN[49], CFGDSN[49]);
  buf B_CFGDSN5 (CFGDSN_IN[5], CFGDSN[5]);
  buf B_CFGDSN50 (CFGDSN_IN[50], CFGDSN[50]);
  buf B_CFGDSN51 (CFGDSN_IN[51], CFGDSN[51]);
  buf B_CFGDSN52 (CFGDSN_IN[52], CFGDSN[52]);
  buf B_CFGDSN53 (CFGDSN_IN[53], CFGDSN[53]);
  buf B_CFGDSN54 (CFGDSN_IN[54], CFGDSN[54]);
  buf B_CFGDSN55 (CFGDSN_IN[55], CFGDSN[55]);
  buf B_CFGDSN56 (CFGDSN_IN[56], CFGDSN[56]);
  buf B_CFGDSN57 (CFGDSN_IN[57], CFGDSN[57]);
  buf B_CFGDSN58 (CFGDSN_IN[58], CFGDSN[58]);
  buf B_CFGDSN59 (CFGDSN_IN[59], CFGDSN[59]);
  buf B_CFGDSN6 (CFGDSN_IN[6], CFGDSN[6]);
  buf B_CFGDSN60 (CFGDSN_IN[60], CFGDSN[60]);
  buf B_CFGDSN61 (CFGDSN_IN[61], CFGDSN[61]);
  buf B_CFGDSN62 (CFGDSN_IN[62], CFGDSN[62]);
  buf B_CFGDSN63 (CFGDSN_IN[63], CFGDSN[63]);
  buf B_CFGDSN7 (CFGDSN_IN[7], CFGDSN[7]);
  buf B_CFGDSN8 (CFGDSN_IN[8], CFGDSN[8]);
  buf B_CFGDSN9 (CFGDSN_IN[9], CFGDSN[9]);
  buf B_CFGDWADDR0 (CFGDWADDR_IN[0], CFGDWADDR[0]);
  buf B_CFGDWADDR1 (CFGDWADDR_IN[1], CFGDWADDR[1]);
  buf B_CFGDWADDR2 (CFGDWADDR_IN[2], CFGDWADDR[2]);
  buf B_CFGDWADDR3 (CFGDWADDR_IN[3], CFGDWADDR[3]);
  buf B_CFGDWADDR4 (CFGDWADDR_IN[4], CFGDWADDR[4]);
  buf B_CFGDWADDR5 (CFGDWADDR_IN[5], CFGDWADDR[5]);
  buf B_CFGDWADDR6 (CFGDWADDR_IN[6], CFGDWADDR[6]);
  buf B_CFGDWADDR7 (CFGDWADDR_IN[7], CFGDWADDR[7]);
  buf B_CFGDWADDR8 (CFGDWADDR_IN[8], CFGDWADDR[8]);
  buf B_CFGDWADDR9 (CFGDWADDR_IN[9], CFGDWADDR[9]);
//  buf B_CFGERRCORN (CFGERRCORN_IN, CFGERRCORN);
//  buf B_CFGERRCPLABORTN (CFGERRCPLABORTN_IN, CFGERRCPLABORTN);
//  buf B_CFGERRCPLTIMEOUTN (CFGERRCPLTIMEOUTN_IN, CFGERRCPLTIMEOUTN);
//  buf B_CFGERRECRCN (CFGERRECRCN_IN, CFGERRECRCN);
//  buf B_CFGERRLOCKEDN (CFGERRLOCKEDN_IN, CFGERRLOCKEDN);
//  buf B_CFGERRPOSTEDN (CFGERRPOSTEDN_IN, CFGERRPOSTEDN);
  buf B_CFGERRTLPCPLHEADER0 (CFGERRTLPCPLHEADER_IN[0], CFGERRTLPCPLHEADER[0]);
  buf B_CFGERRTLPCPLHEADER1 (CFGERRTLPCPLHEADER_IN[1], CFGERRTLPCPLHEADER[1]);
  buf B_CFGERRTLPCPLHEADER10 (CFGERRTLPCPLHEADER_IN[10], CFGERRTLPCPLHEADER[10]);
  buf B_CFGERRTLPCPLHEADER11 (CFGERRTLPCPLHEADER_IN[11], CFGERRTLPCPLHEADER[11]);
  buf B_CFGERRTLPCPLHEADER12 (CFGERRTLPCPLHEADER_IN[12], CFGERRTLPCPLHEADER[12]);
  buf B_CFGERRTLPCPLHEADER13 (CFGERRTLPCPLHEADER_IN[13], CFGERRTLPCPLHEADER[13]);
  buf B_CFGERRTLPCPLHEADER14 (CFGERRTLPCPLHEADER_IN[14], CFGERRTLPCPLHEADER[14]);
  buf B_CFGERRTLPCPLHEADER15 (CFGERRTLPCPLHEADER_IN[15], CFGERRTLPCPLHEADER[15]);
  buf B_CFGERRTLPCPLHEADER16 (CFGERRTLPCPLHEADER_IN[16], CFGERRTLPCPLHEADER[16]);
  buf B_CFGERRTLPCPLHEADER17 (CFGERRTLPCPLHEADER_IN[17], CFGERRTLPCPLHEADER[17]);
  buf B_CFGERRTLPCPLHEADER18 (CFGERRTLPCPLHEADER_IN[18], CFGERRTLPCPLHEADER[18]);
  buf B_CFGERRTLPCPLHEADER19 (CFGERRTLPCPLHEADER_IN[19], CFGERRTLPCPLHEADER[19]);
  buf B_CFGERRTLPCPLHEADER2 (CFGERRTLPCPLHEADER_IN[2], CFGERRTLPCPLHEADER[2]);
  buf B_CFGERRTLPCPLHEADER20 (CFGERRTLPCPLHEADER_IN[20], CFGERRTLPCPLHEADER[20]);
  buf B_CFGERRTLPCPLHEADER21 (CFGERRTLPCPLHEADER_IN[21], CFGERRTLPCPLHEADER[21]);
  buf B_CFGERRTLPCPLHEADER22 (CFGERRTLPCPLHEADER_IN[22], CFGERRTLPCPLHEADER[22]);
  buf B_CFGERRTLPCPLHEADER23 (CFGERRTLPCPLHEADER_IN[23], CFGERRTLPCPLHEADER[23]);
  buf B_CFGERRTLPCPLHEADER24 (CFGERRTLPCPLHEADER_IN[24], CFGERRTLPCPLHEADER[24]);
  buf B_CFGERRTLPCPLHEADER25 (CFGERRTLPCPLHEADER_IN[25], CFGERRTLPCPLHEADER[25]);
  buf B_CFGERRTLPCPLHEADER26 (CFGERRTLPCPLHEADER_IN[26], CFGERRTLPCPLHEADER[26]);
  buf B_CFGERRTLPCPLHEADER27 (CFGERRTLPCPLHEADER_IN[27], CFGERRTLPCPLHEADER[27]);
  buf B_CFGERRTLPCPLHEADER28 (CFGERRTLPCPLHEADER_IN[28], CFGERRTLPCPLHEADER[28]);
  buf B_CFGERRTLPCPLHEADER29 (CFGERRTLPCPLHEADER_IN[29], CFGERRTLPCPLHEADER[29]);
  buf B_CFGERRTLPCPLHEADER3 (CFGERRTLPCPLHEADER_IN[3], CFGERRTLPCPLHEADER[3]);
  buf B_CFGERRTLPCPLHEADER30 (CFGERRTLPCPLHEADER_IN[30], CFGERRTLPCPLHEADER[30]);
  buf B_CFGERRTLPCPLHEADER31 (CFGERRTLPCPLHEADER_IN[31], CFGERRTLPCPLHEADER[31]);
  buf B_CFGERRTLPCPLHEADER32 (CFGERRTLPCPLHEADER_IN[32], CFGERRTLPCPLHEADER[32]);
  buf B_CFGERRTLPCPLHEADER33 (CFGERRTLPCPLHEADER_IN[33], CFGERRTLPCPLHEADER[33]);
  buf B_CFGERRTLPCPLHEADER34 (CFGERRTLPCPLHEADER_IN[34], CFGERRTLPCPLHEADER[34]);
  buf B_CFGERRTLPCPLHEADER35 (CFGERRTLPCPLHEADER_IN[35], CFGERRTLPCPLHEADER[35]);
  buf B_CFGERRTLPCPLHEADER36 (CFGERRTLPCPLHEADER_IN[36], CFGERRTLPCPLHEADER[36]);
  buf B_CFGERRTLPCPLHEADER37 (CFGERRTLPCPLHEADER_IN[37], CFGERRTLPCPLHEADER[37]);
  buf B_CFGERRTLPCPLHEADER38 (CFGERRTLPCPLHEADER_IN[38], CFGERRTLPCPLHEADER[38]);
  buf B_CFGERRTLPCPLHEADER39 (CFGERRTLPCPLHEADER_IN[39], CFGERRTLPCPLHEADER[39]);
  buf B_CFGERRTLPCPLHEADER4 (CFGERRTLPCPLHEADER_IN[4], CFGERRTLPCPLHEADER[4]);
  buf B_CFGERRTLPCPLHEADER40 (CFGERRTLPCPLHEADER_IN[40], CFGERRTLPCPLHEADER[40]);
  buf B_CFGERRTLPCPLHEADER41 (CFGERRTLPCPLHEADER_IN[41], CFGERRTLPCPLHEADER[41]);
  buf B_CFGERRTLPCPLHEADER42 (CFGERRTLPCPLHEADER_IN[42], CFGERRTLPCPLHEADER[42]);
  buf B_CFGERRTLPCPLHEADER43 (CFGERRTLPCPLHEADER_IN[43], CFGERRTLPCPLHEADER[43]);
  buf B_CFGERRTLPCPLHEADER44 (CFGERRTLPCPLHEADER_IN[44], CFGERRTLPCPLHEADER[44]);
  buf B_CFGERRTLPCPLHEADER45 (CFGERRTLPCPLHEADER_IN[45], CFGERRTLPCPLHEADER[45]);
  buf B_CFGERRTLPCPLHEADER46 (CFGERRTLPCPLHEADER_IN[46], CFGERRTLPCPLHEADER[46]);
  buf B_CFGERRTLPCPLHEADER47 (CFGERRTLPCPLHEADER_IN[47], CFGERRTLPCPLHEADER[47]);
  buf B_CFGERRTLPCPLHEADER5 (CFGERRTLPCPLHEADER_IN[5], CFGERRTLPCPLHEADER[5]);
  buf B_CFGERRTLPCPLHEADER6 (CFGERRTLPCPLHEADER_IN[6], CFGERRTLPCPLHEADER[6]);
  buf B_CFGERRTLPCPLHEADER7 (CFGERRTLPCPLHEADER_IN[7], CFGERRTLPCPLHEADER[7]);
  buf B_CFGERRTLPCPLHEADER8 (CFGERRTLPCPLHEADER_IN[8], CFGERRTLPCPLHEADER[8]);
  buf B_CFGERRTLPCPLHEADER9 (CFGERRTLPCPLHEADER_IN[9], CFGERRTLPCPLHEADER[9]);
//  buf B_CFGERRURN (CFGERRURN_IN, CFGERRURN);
//  buf B_CFGINTERRUPTASSERTN (CFGINTERRUPTASSERTN_IN, CFGINTERRUPTASSERTN);
  buf B_CFGINTERRUPTDI0 (CFGINTERRUPTDI_IN[0], CFGINTERRUPTDI[0]);
  buf B_CFGINTERRUPTDI1 (CFGINTERRUPTDI_IN[1], CFGINTERRUPTDI[1]);
  buf B_CFGINTERRUPTDI2 (CFGINTERRUPTDI_IN[2], CFGINTERRUPTDI[2]);
  buf B_CFGINTERRUPTDI3 (CFGINTERRUPTDI_IN[3], CFGINTERRUPTDI[3]);
  buf B_CFGINTERRUPTDI4 (CFGINTERRUPTDI_IN[4], CFGINTERRUPTDI[4]);
  buf B_CFGINTERRUPTDI5 (CFGINTERRUPTDI_IN[5], CFGINTERRUPTDI[5]);
  buf B_CFGINTERRUPTDI6 (CFGINTERRUPTDI_IN[6], CFGINTERRUPTDI[6]);
  buf B_CFGINTERRUPTDI7 (CFGINTERRUPTDI_IN[7], CFGINTERRUPTDI[7]);
//  buf B_CFGINTERRUPTN (CFGINTERRUPTN_IN, CFGINTERRUPTN);
//  buf B_CFGPMWAKEN (CFGPMWAKEN_IN, CFGPMWAKEN);
//  buf B_CFGRDENN (CFGRDENN_IN, CFGRDENN);
  buf B_CFGREVID0 (CFGREVID_IN[0], CFGREVID[0]);
  buf B_CFGREVID1 (CFGREVID_IN[1], CFGREVID[1]);
  buf B_CFGREVID2 (CFGREVID_IN[2], CFGREVID[2]);
  buf B_CFGREVID3 (CFGREVID_IN[3], CFGREVID[3]);
  buf B_CFGREVID4 (CFGREVID_IN[4], CFGREVID[4]);
  buf B_CFGREVID5 (CFGREVID_IN[5], CFGREVID[5]);
  buf B_CFGREVID6 (CFGREVID_IN[6], CFGREVID[6]);
  buf B_CFGREVID7 (CFGREVID_IN[7], CFGREVID[7]);
  buf B_CFGSUBSYSID0 (CFGSUBSYSID_IN[0], CFGSUBSYSID[0]);
  buf B_CFGSUBSYSID1 (CFGSUBSYSID_IN[1], CFGSUBSYSID[1]);
  buf B_CFGSUBSYSID10 (CFGSUBSYSID_IN[10], CFGSUBSYSID[10]);
  buf B_CFGSUBSYSID11 (CFGSUBSYSID_IN[11], CFGSUBSYSID[11]);
  buf B_CFGSUBSYSID12 (CFGSUBSYSID_IN[12], CFGSUBSYSID[12]);
  buf B_CFGSUBSYSID13 (CFGSUBSYSID_IN[13], CFGSUBSYSID[13]);
  buf B_CFGSUBSYSID14 (CFGSUBSYSID_IN[14], CFGSUBSYSID[14]);
  buf B_CFGSUBSYSID15 (CFGSUBSYSID_IN[15], CFGSUBSYSID[15]);
  buf B_CFGSUBSYSID2 (CFGSUBSYSID_IN[2], CFGSUBSYSID[2]);
  buf B_CFGSUBSYSID3 (CFGSUBSYSID_IN[3], CFGSUBSYSID[3]);
  buf B_CFGSUBSYSID4 (CFGSUBSYSID_IN[4], CFGSUBSYSID[4]);
  buf B_CFGSUBSYSID5 (CFGSUBSYSID_IN[5], CFGSUBSYSID[5]);
  buf B_CFGSUBSYSID6 (CFGSUBSYSID_IN[6], CFGSUBSYSID[6]);
  buf B_CFGSUBSYSID7 (CFGSUBSYSID_IN[7], CFGSUBSYSID[7]);
  buf B_CFGSUBSYSID8 (CFGSUBSYSID_IN[8], CFGSUBSYSID[8]);
  buf B_CFGSUBSYSID9 (CFGSUBSYSID_IN[9], CFGSUBSYSID[9]);
  buf B_CFGSUBSYSVENID0 (CFGSUBSYSVENID_IN[0], CFGSUBSYSVENID[0]);
  buf B_CFGSUBSYSVENID1 (CFGSUBSYSVENID_IN[1], CFGSUBSYSVENID[1]);
  buf B_CFGSUBSYSVENID10 (CFGSUBSYSVENID_IN[10], CFGSUBSYSVENID[10]);
  buf B_CFGSUBSYSVENID11 (CFGSUBSYSVENID_IN[11], CFGSUBSYSVENID[11]);
  buf B_CFGSUBSYSVENID12 (CFGSUBSYSVENID_IN[12], CFGSUBSYSVENID[12]);
  buf B_CFGSUBSYSVENID13 (CFGSUBSYSVENID_IN[13], CFGSUBSYSVENID[13]);
  buf B_CFGSUBSYSVENID14 (CFGSUBSYSVENID_IN[14], CFGSUBSYSVENID[14]);
  buf B_CFGSUBSYSVENID15 (CFGSUBSYSVENID_IN[15], CFGSUBSYSVENID[15]);
  buf B_CFGSUBSYSVENID2 (CFGSUBSYSVENID_IN[2], CFGSUBSYSVENID[2]);
  buf B_CFGSUBSYSVENID3 (CFGSUBSYSVENID_IN[3], CFGSUBSYSVENID[3]);
  buf B_CFGSUBSYSVENID4 (CFGSUBSYSVENID_IN[4], CFGSUBSYSVENID[4]);
  buf B_CFGSUBSYSVENID5 (CFGSUBSYSVENID_IN[5], CFGSUBSYSVENID[5]);
  buf B_CFGSUBSYSVENID6 (CFGSUBSYSVENID_IN[6], CFGSUBSYSVENID[6]);
  buf B_CFGSUBSYSVENID7 (CFGSUBSYSVENID_IN[7], CFGSUBSYSVENID[7]);
  buf B_CFGSUBSYSVENID8 (CFGSUBSYSVENID_IN[8], CFGSUBSYSVENID[8]);
  buf B_CFGSUBSYSVENID9 (CFGSUBSYSVENID_IN[9], CFGSUBSYSVENID[9]);
//  buf B_CFGTRNPENDINGN (CFGTRNPENDINGN_IN, CFGTRNPENDINGN);
//  buf B_CFGTURNOFFOKN (CFGTURNOFFOKN_IN, CFGTURNOFFOKN);
  buf B_CFGVENID0 (CFGVENID_IN[0], CFGVENID[0]);
  buf B_CFGVENID1 (CFGVENID_IN[1], CFGVENID[1]);
  buf B_CFGVENID10 (CFGVENID_IN[10], CFGVENID[10]);
  buf B_CFGVENID11 (CFGVENID_IN[11], CFGVENID[11]);
  buf B_CFGVENID12 (CFGVENID_IN[12], CFGVENID[12]);
  buf B_CFGVENID13 (CFGVENID_IN[13], CFGVENID[13]);
  buf B_CFGVENID14 (CFGVENID_IN[14], CFGVENID[14]);
  buf B_CFGVENID15 (CFGVENID_IN[15], CFGVENID[15]);
  buf B_CFGVENID2 (CFGVENID_IN[2], CFGVENID[2]);
  buf B_CFGVENID3 (CFGVENID_IN[3], CFGVENID[3]);
  buf B_CFGVENID4 (CFGVENID_IN[4], CFGVENID[4]);
  buf B_CFGVENID5 (CFGVENID_IN[5], CFGVENID[5]);
  buf B_CFGVENID6 (CFGVENID_IN[6], CFGVENID[6]);
  buf B_CFGVENID7 (CFGVENID_IN[7], CFGVENID[7]);
  buf B_CFGVENID8 (CFGVENID_IN[8], CFGVENID[8]);
  buf B_CFGVENID9 (CFGVENID_IN[9], CFGVENID[9]);
  buf B_CLOCKLOCKED (CLOCKLOCKED_IN, CLOCKLOCKED);
//  buf B_MGTCLK (MGTCLK_IN, MGTCLK);
  buf B_MIMRXRDATA0 (MIMRXRDATA_IN[0], MIMRXRDATA[0]);
  buf B_MIMRXRDATA1 (MIMRXRDATA_IN[1], MIMRXRDATA[1]);
  buf B_MIMRXRDATA10 (MIMRXRDATA_IN[10], MIMRXRDATA[10]);
  buf B_MIMRXRDATA11 (MIMRXRDATA_IN[11], MIMRXRDATA[11]);
  buf B_MIMRXRDATA12 (MIMRXRDATA_IN[12], MIMRXRDATA[12]);
  buf B_MIMRXRDATA13 (MIMRXRDATA_IN[13], MIMRXRDATA[13]);
  buf B_MIMRXRDATA14 (MIMRXRDATA_IN[14], MIMRXRDATA[14]);
  buf B_MIMRXRDATA15 (MIMRXRDATA_IN[15], MIMRXRDATA[15]);
  buf B_MIMRXRDATA16 (MIMRXRDATA_IN[16], MIMRXRDATA[16]);
  buf B_MIMRXRDATA17 (MIMRXRDATA_IN[17], MIMRXRDATA[17]);
  buf B_MIMRXRDATA18 (MIMRXRDATA_IN[18], MIMRXRDATA[18]);
  buf B_MIMRXRDATA19 (MIMRXRDATA_IN[19], MIMRXRDATA[19]);
  buf B_MIMRXRDATA2 (MIMRXRDATA_IN[2], MIMRXRDATA[2]);
  buf B_MIMRXRDATA20 (MIMRXRDATA_IN[20], MIMRXRDATA[20]);
  buf B_MIMRXRDATA21 (MIMRXRDATA_IN[21], MIMRXRDATA[21]);
  buf B_MIMRXRDATA22 (MIMRXRDATA_IN[22], MIMRXRDATA[22]);
  buf B_MIMRXRDATA23 (MIMRXRDATA_IN[23], MIMRXRDATA[23]);
  buf B_MIMRXRDATA24 (MIMRXRDATA_IN[24], MIMRXRDATA[24]);
  buf B_MIMRXRDATA25 (MIMRXRDATA_IN[25], MIMRXRDATA[25]);
  buf B_MIMRXRDATA26 (MIMRXRDATA_IN[26], MIMRXRDATA[26]);
  buf B_MIMRXRDATA27 (MIMRXRDATA_IN[27], MIMRXRDATA[27]);
  buf B_MIMRXRDATA28 (MIMRXRDATA_IN[28], MIMRXRDATA[28]);
  buf B_MIMRXRDATA29 (MIMRXRDATA_IN[29], MIMRXRDATA[29]);
  buf B_MIMRXRDATA3 (MIMRXRDATA_IN[3], MIMRXRDATA[3]);
  buf B_MIMRXRDATA30 (MIMRXRDATA_IN[30], MIMRXRDATA[30]);
  buf B_MIMRXRDATA31 (MIMRXRDATA_IN[31], MIMRXRDATA[31]);
  buf B_MIMRXRDATA32 (MIMRXRDATA_IN[32], MIMRXRDATA[32]);
  buf B_MIMRXRDATA33 (MIMRXRDATA_IN[33], MIMRXRDATA[33]);
  buf B_MIMRXRDATA34 (MIMRXRDATA_IN[34], MIMRXRDATA[34]);
  buf B_MIMRXRDATA4 (MIMRXRDATA_IN[4], MIMRXRDATA[4]);
  buf B_MIMRXRDATA5 (MIMRXRDATA_IN[5], MIMRXRDATA[5]);
  buf B_MIMRXRDATA6 (MIMRXRDATA_IN[6], MIMRXRDATA[6]);
  buf B_MIMRXRDATA7 (MIMRXRDATA_IN[7], MIMRXRDATA[7]);
  buf B_MIMRXRDATA8 (MIMRXRDATA_IN[8], MIMRXRDATA[8]);
  buf B_MIMRXRDATA9 (MIMRXRDATA_IN[9], MIMRXRDATA[9]);
  buf B_MIMTXRDATA0 (MIMTXRDATA_IN[0], MIMTXRDATA[0]);
  buf B_MIMTXRDATA1 (MIMTXRDATA_IN[1], MIMTXRDATA[1]);
  buf B_MIMTXRDATA10 (MIMTXRDATA_IN[10], MIMTXRDATA[10]);
  buf B_MIMTXRDATA11 (MIMTXRDATA_IN[11], MIMTXRDATA[11]);
  buf B_MIMTXRDATA12 (MIMTXRDATA_IN[12], MIMTXRDATA[12]);
  buf B_MIMTXRDATA13 (MIMTXRDATA_IN[13], MIMTXRDATA[13]);
  buf B_MIMTXRDATA14 (MIMTXRDATA_IN[14], MIMTXRDATA[14]);
  buf B_MIMTXRDATA15 (MIMTXRDATA_IN[15], MIMTXRDATA[15]);
  buf B_MIMTXRDATA16 (MIMTXRDATA_IN[16], MIMTXRDATA[16]);
  buf B_MIMTXRDATA17 (MIMTXRDATA_IN[17], MIMTXRDATA[17]);
  buf B_MIMTXRDATA18 (MIMTXRDATA_IN[18], MIMTXRDATA[18]);
  buf B_MIMTXRDATA19 (MIMTXRDATA_IN[19], MIMTXRDATA[19]);
  buf B_MIMTXRDATA2 (MIMTXRDATA_IN[2], MIMTXRDATA[2]);
  buf B_MIMTXRDATA20 (MIMTXRDATA_IN[20], MIMTXRDATA[20]);
  buf B_MIMTXRDATA21 (MIMTXRDATA_IN[21], MIMTXRDATA[21]);
  buf B_MIMTXRDATA22 (MIMTXRDATA_IN[22], MIMTXRDATA[22]);
  buf B_MIMTXRDATA23 (MIMTXRDATA_IN[23], MIMTXRDATA[23]);
  buf B_MIMTXRDATA24 (MIMTXRDATA_IN[24], MIMTXRDATA[24]);
  buf B_MIMTXRDATA25 (MIMTXRDATA_IN[25], MIMTXRDATA[25]);
  buf B_MIMTXRDATA26 (MIMTXRDATA_IN[26], MIMTXRDATA[26]);
  buf B_MIMTXRDATA27 (MIMTXRDATA_IN[27], MIMTXRDATA[27]);
  buf B_MIMTXRDATA28 (MIMTXRDATA_IN[28], MIMTXRDATA[28]);
  buf B_MIMTXRDATA29 (MIMTXRDATA_IN[29], MIMTXRDATA[29]);
  buf B_MIMTXRDATA3 (MIMTXRDATA_IN[3], MIMTXRDATA[3]);
  buf B_MIMTXRDATA30 (MIMTXRDATA_IN[30], MIMTXRDATA[30]);
  buf B_MIMTXRDATA31 (MIMTXRDATA_IN[31], MIMTXRDATA[31]);
  buf B_MIMTXRDATA32 (MIMTXRDATA_IN[32], MIMTXRDATA[32]);
  buf B_MIMTXRDATA33 (MIMTXRDATA_IN[33], MIMTXRDATA[33]);
  buf B_MIMTXRDATA34 (MIMTXRDATA_IN[34], MIMTXRDATA[34]);
  buf B_MIMTXRDATA35 (MIMTXRDATA_IN[35], MIMTXRDATA[35]);
  buf B_MIMTXRDATA4 (MIMTXRDATA_IN[4], MIMTXRDATA[4]);
  buf B_MIMTXRDATA5 (MIMTXRDATA_IN[5], MIMTXRDATA[5]);
  buf B_MIMTXRDATA6 (MIMTXRDATA_IN[6], MIMTXRDATA[6]);
  buf B_MIMTXRDATA7 (MIMTXRDATA_IN[7], MIMTXRDATA[7]);
  buf B_MIMTXRDATA8 (MIMTXRDATA_IN[8], MIMTXRDATA[8]);
  buf B_MIMTXRDATA9 (MIMTXRDATA_IN[9], MIMTXRDATA[9]);
//  buf B_PIPEGTRESETDONEA (PIPEGTRESETDONEA_IN, PIPEGTRESETDONEA);
//  buf B_PIPEGTRESETDONEB (PIPEGTRESETDONEB_IN, PIPEGTRESETDONEB);
//  buf B_PIPEPHYSTATUSA (PIPEPHYSTATUSA_IN, PIPEPHYSTATUSA);
//  buf B_PIPEPHYSTATUSB (PIPEPHYSTATUSB_IN, PIPEPHYSTATUSB);
  buf B_PIPERXCHARISKA0 (PIPERXCHARISKA_IN[0], PIPERXCHARISKA[0]);
  buf B_PIPERXCHARISKA1 (PIPERXCHARISKA_IN[1], PIPERXCHARISKA[1]);
  buf B_PIPERXCHARISKB0 (PIPERXCHARISKB_IN[0], PIPERXCHARISKB[0]);
  buf B_PIPERXCHARISKB1 (PIPERXCHARISKB_IN[1], PIPERXCHARISKB[1]);
  buf B_PIPERXDATAA0 (PIPERXDATAA_IN[0], PIPERXDATAA[0]);
  buf B_PIPERXDATAA1 (PIPERXDATAA_IN[1], PIPERXDATAA[1]);
  buf B_PIPERXDATAA10 (PIPERXDATAA_IN[10], PIPERXDATAA[10]);
  buf B_PIPERXDATAA11 (PIPERXDATAA_IN[11], PIPERXDATAA[11]);
  buf B_PIPERXDATAA12 (PIPERXDATAA_IN[12], PIPERXDATAA[12]);
  buf B_PIPERXDATAA13 (PIPERXDATAA_IN[13], PIPERXDATAA[13]);
  buf B_PIPERXDATAA14 (PIPERXDATAA_IN[14], PIPERXDATAA[14]);
  buf B_PIPERXDATAA15 (PIPERXDATAA_IN[15], PIPERXDATAA[15]);
  buf B_PIPERXDATAA2 (PIPERXDATAA_IN[2], PIPERXDATAA[2]);
  buf B_PIPERXDATAA3 (PIPERXDATAA_IN[3], PIPERXDATAA[3]);
  buf B_PIPERXDATAA4 (PIPERXDATAA_IN[4], PIPERXDATAA[4]);
  buf B_PIPERXDATAA5 (PIPERXDATAA_IN[5], PIPERXDATAA[5]);
  buf B_PIPERXDATAA6 (PIPERXDATAA_IN[6], PIPERXDATAA[6]);
  buf B_PIPERXDATAA7 (PIPERXDATAA_IN[7], PIPERXDATAA[7]);
  buf B_PIPERXDATAA8 (PIPERXDATAA_IN[8], PIPERXDATAA[8]);
  buf B_PIPERXDATAA9 (PIPERXDATAA_IN[9], PIPERXDATAA[9]);
  buf B_PIPERXDATAB0 (PIPERXDATAB_IN[0], PIPERXDATAB[0]);
  buf B_PIPERXDATAB1 (PIPERXDATAB_IN[1], PIPERXDATAB[1]);
  buf B_PIPERXDATAB10 (PIPERXDATAB_IN[10], PIPERXDATAB[10]);
  buf B_PIPERXDATAB11 (PIPERXDATAB_IN[11], PIPERXDATAB[11]);
  buf B_PIPERXDATAB12 (PIPERXDATAB_IN[12], PIPERXDATAB[12]);
  buf B_PIPERXDATAB13 (PIPERXDATAB_IN[13], PIPERXDATAB[13]);
  buf B_PIPERXDATAB14 (PIPERXDATAB_IN[14], PIPERXDATAB[14]);
  buf B_PIPERXDATAB15 (PIPERXDATAB_IN[15], PIPERXDATAB[15]);
  buf B_PIPERXDATAB2 (PIPERXDATAB_IN[2], PIPERXDATAB[2]);
  buf B_PIPERXDATAB3 (PIPERXDATAB_IN[3], PIPERXDATAB[3]);
  buf B_PIPERXDATAB4 (PIPERXDATAB_IN[4], PIPERXDATAB[4]);
  buf B_PIPERXDATAB5 (PIPERXDATAB_IN[5], PIPERXDATAB[5]);
  buf B_PIPERXDATAB6 (PIPERXDATAB_IN[6], PIPERXDATAB[6]);
  buf B_PIPERXDATAB7 (PIPERXDATAB_IN[7], PIPERXDATAB[7]);
  buf B_PIPERXDATAB8 (PIPERXDATAB_IN[8], PIPERXDATAB[8]);
  buf B_PIPERXDATAB9 (PIPERXDATAB_IN[9], PIPERXDATAB[9]);
//  buf B_PIPERXENTERELECIDLEA (PIPERXENTERELECIDLEA_IN, PIPERXENTERELECIDLEA);
//  buf B_PIPERXENTERELECIDLEB (PIPERXENTERELECIDLEB_IN, PIPERXENTERELECIDLEB);
  buf B_PIPERXSTATUSA0 (PIPERXSTATUSA_IN[0], PIPERXSTATUSA[0]);
  buf B_PIPERXSTATUSA1 (PIPERXSTATUSA_IN[1], PIPERXSTATUSA[1]);
  buf B_PIPERXSTATUSA2 (PIPERXSTATUSA_IN[2], PIPERXSTATUSA[2]);
  buf B_PIPERXSTATUSB0 (PIPERXSTATUSB_IN[0], PIPERXSTATUSB[0]);
  buf B_PIPERXSTATUSB1 (PIPERXSTATUSB_IN[1], PIPERXSTATUSB[1]);
  buf B_PIPERXSTATUSB2 (PIPERXSTATUSB_IN[2], PIPERXSTATUSB[2]);
  buf B_SYSRESETN (SYSRESETN_IN, SYSRESETN);
  buf B_TRNFCSEL0 (TRNFCSEL_IN[0], TRNFCSEL[0]);
  buf B_TRNFCSEL1 (TRNFCSEL_IN[1], TRNFCSEL[1]);
  buf B_TRNFCSEL2 (TRNFCSEL_IN[2], TRNFCSEL[2]);
//  buf B_TRNRDSTRDYN (TRNRDSTRDYN_IN, TRNRDSTRDYN);
//  buf B_TRNRNPOKN (TRNRNPOKN_IN, TRNRNPOKN);
//  buf B_TRNTCFGGNTN (TRNTCFGGNTN_IN, TRNTCFGGNTN);
  buf B_TRNTD0 (TRNTD_IN[0], TRNTD[0]);
  buf B_TRNTD1 (TRNTD_IN[1], TRNTD[1]);
  buf B_TRNTD10 (TRNTD_IN[10], TRNTD[10]);
  buf B_TRNTD11 (TRNTD_IN[11], TRNTD[11]);
  buf B_TRNTD12 (TRNTD_IN[12], TRNTD[12]);
  buf B_TRNTD13 (TRNTD_IN[13], TRNTD[13]);
  buf B_TRNTD14 (TRNTD_IN[14], TRNTD[14]);
  buf B_TRNTD15 (TRNTD_IN[15], TRNTD[15]);
  buf B_TRNTD16 (TRNTD_IN[16], TRNTD[16]);
  buf B_TRNTD17 (TRNTD_IN[17], TRNTD[17]);
  buf B_TRNTD18 (TRNTD_IN[18], TRNTD[18]);
  buf B_TRNTD19 (TRNTD_IN[19], TRNTD[19]);
  buf B_TRNTD2 (TRNTD_IN[2], TRNTD[2]);
  buf B_TRNTD20 (TRNTD_IN[20], TRNTD[20]);
  buf B_TRNTD21 (TRNTD_IN[21], TRNTD[21]);
  buf B_TRNTD22 (TRNTD_IN[22], TRNTD[22]);
  buf B_TRNTD23 (TRNTD_IN[23], TRNTD[23]);
  buf B_TRNTD24 (TRNTD_IN[24], TRNTD[24]);
  buf B_TRNTD25 (TRNTD_IN[25], TRNTD[25]);
  buf B_TRNTD26 (TRNTD_IN[26], TRNTD[26]);
  buf B_TRNTD27 (TRNTD_IN[27], TRNTD[27]);
  buf B_TRNTD28 (TRNTD_IN[28], TRNTD[28]);
  buf B_TRNTD29 (TRNTD_IN[29], TRNTD[29]);
  buf B_TRNTD3 (TRNTD_IN[3], TRNTD[3]);
  buf B_TRNTD30 (TRNTD_IN[30], TRNTD[30]);
  buf B_TRNTD31 (TRNTD_IN[31], TRNTD[31]);
  buf B_TRNTD4 (TRNTD_IN[4], TRNTD[4]);
  buf B_TRNTD5 (TRNTD_IN[5], TRNTD[5]);
  buf B_TRNTD6 (TRNTD_IN[6], TRNTD[6]);
  buf B_TRNTD7 (TRNTD_IN[7], TRNTD[7]);
  buf B_TRNTD8 (TRNTD_IN[8], TRNTD[8]);
  buf B_TRNTD9 (TRNTD_IN[9], TRNTD[9]);
//  buf B_TRNTEOFN (TRNTEOFN_IN, TRNTEOFN);
//  buf B_TRNTERRFWDN (TRNTERRFWDN_IN, TRNTERRFWDN);
//  buf B_TRNTSOFN (TRNTSOFN_IN, TRNTSOFN);
//  buf B_TRNTSRCDSCN (TRNTSRCDSCN_IN, TRNTSRCDSCN);
//  buf B_TRNTSRCRDYN (TRNTSRCRDYN_IN, TRNTSRCRDYN);
//  buf B_TRNTSTRN (TRNTSTRN_IN, TRNTSTRN);
//  buf B_USERCLK (USERCLK_IN, USERCLK);

  reg USERCLK_SAMPLE = 0;
  reg M_U_CHECK = 0;
  wire M_U_CHECK_wire = M_U_CHECK;
  reg U_M_CHECK = 0;
  wire U_M_CHECK_wire = U_M_CHECK;

  assign #(out_delay) CFGBUSNUMBER_OUTDELAY = CFGBUSNUMBER_OUT;
  assign #(out_delay) CFGCOMMANDBUSMASTERENABLE_OUTDELAY = CFGCOMMANDBUSMASTERENABLE_OUT;
  assign #(out_delay) CFGCOMMANDINTERRUPTDISABLE_OUTDELAY = CFGCOMMANDINTERRUPTDISABLE_OUT;
  assign #(out_delay) CFGCOMMANDIOENABLE_OUTDELAY = CFGCOMMANDIOENABLE_OUT;
  assign #(out_delay) CFGCOMMANDMEMENABLE_OUTDELAY = CFGCOMMANDMEMENABLE_OUT;
  assign #(out_delay) CFGCOMMANDSERREN_OUTDELAY = CFGCOMMANDSERREN_OUT;
  assign #(out_delay) CFGDEVCONTROLAUXPOWEREN_OUTDELAY = CFGDEVCONTROLAUXPOWEREN_OUT;
  assign #(out_delay) CFGDEVCONTROLCORRERRREPORTINGEN_OUTDELAY = CFGDEVCONTROLCORRERRREPORTINGEN_OUT;
  assign #(out_delay) CFGDEVCONTROLENABLERO_OUTDELAY = CFGDEVCONTROLENABLERO_OUT;
  assign #(out_delay) CFGDEVCONTROLEXTTAGEN_OUTDELAY = CFGDEVCONTROLEXTTAGEN_OUT;
  assign #(out_delay) CFGDEVCONTROLFATALERRREPORTINGEN_OUTDELAY = CFGDEVCONTROLFATALERRREPORTINGEN_OUT;
  assign #(out_delay) CFGDEVCONTROLMAXPAYLOAD_OUTDELAY = CFGDEVCONTROLMAXPAYLOAD_OUT;
  assign #(out_delay) CFGDEVCONTROLMAXREADREQ_OUTDELAY = CFGDEVCONTROLMAXREADREQ_OUT;
  assign #(out_delay) CFGDEVCONTROLNONFATALREPORTINGEN_OUTDELAY = CFGDEVCONTROLNONFATALREPORTINGEN_OUT;
  assign #(out_delay) CFGDEVCONTROLNOSNOOPEN_OUTDELAY = CFGDEVCONTROLNOSNOOPEN_OUT;
  assign #(out_delay) CFGDEVCONTROLPHANTOMEN_OUTDELAY = CFGDEVCONTROLPHANTOMEN_OUT;
  assign #(out_delay) CFGDEVCONTROLURERRREPORTINGEN_OUTDELAY = CFGDEVCONTROLURERRREPORTINGEN_OUT;
  assign #(out_delay) CFGDEVICENUMBER_OUTDELAY = CFGDEVICENUMBER_OUT;
  assign #(out_delay) CFGDEVSTATUSCORRERRDETECTED_OUTDELAY = CFGDEVSTATUSCORRERRDETECTED_OUT;
  assign #(out_delay) CFGDEVSTATUSFATALERRDETECTED_OUTDELAY = CFGDEVSTATUSFATALERRDETECTED_OUT;
  assign #(out_delay) CFGDEVSTATUSNONFATALERRDETECTED_OUTDELAY = CFGDEVSTATUSNONFATALERRDETECTED_OUT;
  assign #(out_delay) CFGDEVSTATUSURDETECTED_OUTDELAY = CFGDEVSTATUSURDETECTED_OUT;
  assign #(out_delay) CFGDO_OUTDELAY = CFGDO_OUT;
  assign #(out_delay) CFGERRCPLRDYN_OUTDELAY = CFGERRCPLRDYN_OUT;
  assign #(out_delay) CFGFUNCTIONNUMBER_OUTDELAY = CFGFUNCTIONNUMBER_OUT;
  assign #(out_delay) CFGINTERRUPTDO_OUTDELAY = CFGINTERRUPTDO_OUT;
  assign #(out_delay) CFGINTERRUPTMMENABLE_OUTDELAY = CFGINTERRUPTMMENABLE_OUT;
  assign #(out_delay) CFGINTERRUPTMSIENABLE_OUTDELAY = CFGINTERRUPTMSIENABLE_OUT;
  assign #(out_delay) CFGINTERRUPTRDYN_OUTDELAY = CFGINTERRUPTRDYN_OUT;
  assign #(out_delay) CFGLINKCONTOLRCB_OUTDELAY = CFGLINKCONTOLRCB_OUT;
  assign #(out_delay) CFGLINKCONTROLASPMCONTROL_OUTDELAY = CFGLINKCONTROLASPMCONTROL_OUT;
  assign #(out_delay) CFGLINKCONTROLCOMMONCLOCK_OUTDELAY = CFGLINKCONTROLCOMMONCLOCK_OUT;
  assign #(out_delay) CFGLINKCONTROLEXTENDEDSYNC_OUTDELAY = CFGLINKCONTROLEXTENDEDSYNC_OUT;
  assign #(out_delay) CFGLTSSMSTATE_OUTDELAY = CFGLTSSMSTATE_OUT;
  assign #(out_delay) CFGPCIELINKSTATEN_OUTDELAY = CFGPCIELINKSTATEN_OUT;
  assign #(out_delay) CFGRDWRDONEN_OUTDELAY = CFGRDWRDONEN_OUT;
  assign #(out_delay) CFGTOTURNOFFN_OUTDELAY = CFGTOTURNOFFN_OUT;
  assign #(out_delay) DBGBADDLLPSTATUS_OUTDELAY = DBGBADDLLPSTATUS_OUT;
  assign #(out_delay) DBGBADTLPLCRC_OUTDELAY = DBGBADTLPLCRC_OUT;
  assign #(out_delay) DBGBADTLPSEQNUM_OUTDELAY = DBGBADTLPSEQNUM_OUT;
  assign #(out_delay) DBGBADTLPSTATUS_OUTDELAY = DBGBADTLPSTATUS_OUT;
  assign #(out_delay) DBGDLPROTOCOLSTATUS_OUTDELAY = DBGDLPROTOCOLSTATUS_OUT;
  assign #(out_delay) DBGFCPROTOCOLERRSTATUS_OUTDELAY = DBGFCPROTOCOLERRSTATUS_OUT;
  assign #(out_delay) DBGMLFRMDLENGTH_OUTDELAY = DBGMLFRMDLENGTH_OUT;
  assign #(out_delay) DBGMLFRMDMPS_OUTDELAY = DBGMLFRMDMPS_OUT;
  assign #(out_delay) DBGMLFRMDTCVC_OUTDELAY = DBGMLFRMDTCVC_OUT;
  assign #(out_delay) DBGMLFRMDTLPSTATUS_OUTDELAY = DBGMLFRMDTLPSTATUS_OUT;
  assign #(out_delay) DBGMLFRMDUNRECTYPE_OUTDELAY = DBGMLFRMDUNRECTYPE_OUT;
  assign #(out_delay) DBGPOISTLPSTATUS_OUTDELAY = DBGPOISTLPSTATUS_OUT;
  assign #(out_delay) DBGRCVROVERFLOWSTATUS_OUTDELAY = DBGRCVROVERFLOWSTATUS_OUT;
  assign #(out_delay) DBGREGDETECTEDCORRECTABLE_OUTDELAY = DBGREGDETECTEDCORRECTABLE_OUT;
  assign #(out_delay) DBGREGDETECTEDFATAL_OUTDELAY = DBGREGDETECTEDFATAL_OUT;
  assign #(out_delay) DBGREGDETECTEDNONFATAL_OUTDELAY = DBGREGDETECTEDNONFATAL_OUT;
  assign #(out_delay) DBGREGDETECTEDUNSUPPORTED_OUTDELAY = DBGREGDETECTEDUNSUPPORTED_OUT;
  assign #(out_delay) DBGRPLYROLLOVERSTATUS_OUTDELAY = DBGRPLYROLLOVERSTATUS_OUT;
  assign #(out_delay) DBGRPLYTIMEOUTSTATUS_OUTDELAY = DBGRPLYTIMEOUTSTATUS_OUT;
  assign #(out_delay) DBGURNOBARHIT_OUTDELAY = DBGURNOBARHIT_OUT;
  assign #(out_delay) DBGURPOISCFGWR_OUTDELAY = DBGURPOISCFGWR_OUT;
  assign #(out_delay) DBGURSTATUS_OUTDELAY = DBGURSTATUS_OUT;
  assign #(out_delay) DBGURUNSUPMSG_OUTDELAY = DBGURUNSUPMSG_OUT;
  assign #(out_delay) MIMRXRADDR_OUTDELAY = MIMRXRADDR_OUT;
  assign #(out_delay) MIMRXREN_OUTDELAY = MIMRXREN_OUT;
  assign #(out_delay) MIMRXWADDR_OUTDELAY = MIMRXWADDR_OUT;
  assign #(out_delay) MIMRXWDATA_OUTDELAY = MIMRXWDATA_OUT;
  assign #(out_delay) MIMRXWEN_OUTDELAY = MIMRXWEN_OUT;
  assign #(out_delay) MIMTXRADDR_OUTDELAY = MIMTXRADDR_OUT;
  assign #(out_delay) MIMTXREN_OUTDELAY = MIMTXREN_OUT;
  assign #(out_delay) MIMTXWADDR_OUTDELAY = MIMTXWADDR_OUT;
  assign #(out_delay) MIMTXWDATA_OUTDELAY = MIMTXWDATA_OUT;
  assign #(out_delay) MIMTXWEN_OUTDELAY = MIMTXWEN_OUT;
  assign #(out_delay) PIPEGTPOWERDOWNA_OUTDELAY = PIPEGTPOWERDOWNA_OUT;
  assign #(out_delay) PIPEGTPOWERDOWNB_OUTDELAY = PIPEGTPOWERDOWNB_OUT;
  assign #(out_delay) PIPEGTTXELECIDLEA_OUTDELAY = PIPEGTTXELECIDLEA_OUT;
  assign #(out_delay) PIPEGTTXELECIDLEB_OUTDELAY = PIPEGTTXELECIDLEB_OUT;
  assign #(out_delay) PIPERXPOLARITYA_OUTDELAY = PIPERXPOLARITYA_OUT;
  assign #(out_delay) PIPERXPOLARITYB_OUTDELAY = PIPERXPOLARITYB_OUT;
  assign #(out_delay) PIPERXRESETA_OUTDELAY = PIPERXRESETA_OUT;
  assign #(out_delay) PIPERXRESETB_OUTDELAY = PIPERXRESETB_OUT;
  assign #(out_delay) PIPETXCHARDISPMODEA_OUTDELAY = PIPETXCHARDISPMODEA_OUT;
  assign #(out_delay) PIPETXCHARDISPMODEB_OUTDELAY = PIPETXCHARDISPMODEB_OUT;
  assign #(out_delay) PIPETXCHARDISPVALA_OUTDELAY = PIPETXCHARDISPVALA_OUT;
  assign #(out_delay) PIPETXCHARDISPVALB_OUTDELAY = PIPETXCHARDISPVALB_OUT;
  assign #(out_delay) PIPETXCHARISKA_OUTDELAY = PIPETXCHARISKA_OUT;
  assign #(out_delay) PIPETXCHARISKB_OUTDELAY = PIPETXCHARISKB_OUT;
  assign #(out_delay) PIPETXDATAA_OUTDELAY = PIPETXDATAA_OUT;
  assign #(out_delay) PIPETXDATAB_OUTDELAY = PIPETXDATAB_OUT;
  assign #(out_delay) PIPETXRCVRDETA_OUTDELAY = PIPETXRCVRDETA_OUT;
  assign #(out_delay) PIPETXRCVRDETB_OUTDELAY = PIPETXRCVRDETB_OUT;
  assign #(out_delay) RECEIVEDHOTRESET_OUTDELAY = RECEIVEDHOTRESET_OUT;
  assign #(out_delay) TRNFCCPLD_OUTDELAY = TRNFCCPLD_OUT;
  assign #(out_delay) TRNFCCPLH_OUTDELAY = TRNFCCPLH_OUT;
  assign #(out_delay) TRNFCNPD_OUTDELAY = TRNFCNPD_OUT;
  assign #(out_delay) TRNFCNPH_OUTDELAY = TRNFCNPH_OUT;
  assign #(out_delay) TRNFCPD_OUTDELAY = TRNFCPD_OUT;
  assign #(out_delay) TRNFCPH_OUTDELAY = TRNFCPH_OUT;
  assign #(out_delay) TRNLNKUPN_OUTDELAY = TRNLNKUPN_OUT;
  assign #(out_delay) TRNRBARHITN_OUTDELAY = TRNRBARHITN_OUT;
  assign #(out_delay) TRNRD_OUTDELAY = TRNRD_OUT;
  assign #(out_delay) TRNREOFN_OUTDELAY = TRNREOFN_OUT;
  assign #(out_delay) TRNRERRFWDN_OUTDELAY = TRNRERRFWDN_OUT;
  assign #(out_delay) TRNRSOFN_OUTDELAY = TRNRSOFN_OUT;
  assign #(out_delay) TRNRSRCDSCN_OUTDELAY = TRNRSRCDSCN_OUT;
  assign #(out_delay) TRNRSRCRDYN_OUTDELAY = TRNRSRCRDYN_OUT;
  assign #(out_delay) TRNTBUFAV_OUTDELAY = TRNTBUFAV_OUT;
  assign #(out_delay) TRNTCFGREQN_OUTDELAY = TRNTCFGREQN_OUT;
  assign #(out_delay) TRNTDSTRDYN_OUTDELAY = TRNTDSTRDYN_OUT;
  assign #(out_delay) TRNTERRDROPN_OUTDELAY = TRNTERRDROPN_OUT;
  assign #(out_delay) USERRSTN_OUTDELAY = USERRSTN_OUT;

  assign #(INCLK_DELAY) MGTCLK_INDELAY = MGTCLK_IN;
  assign #(INCLK_DELAY) USERCLK_INDELAY = USERCLK_IN;

  assign #(in_delay) CFGDEVID_INDELAY = CFGDEVID_IN;
  assign #(in_delay) CFGDSN_INDELAY = CFGDSN_IN;
  assign #(in_delay) CFGDWADDR_INDELAY = CFGDWADDR_IN;
  assign #(in_delay) CFGERRCORN_INDELAY = CFGERRCORN_IN;
  assign #(in_delay) CFGERRCPLABORTN_INDELAY = CFGERRCPLABORTN_IN;
  assign #(in_delay) CFGERRCPLTIMEOUTN_INDELAY = CFGERRCPLTIMEOUTN_IN;
  assign #(in_delay) CFGERRECRCN_INDELAY = CFGERRECRCN_IN;
  assign #(in_delay) CFGERRLOCKEDN_INDELAY = CFGERRLOCKEDN_IN;
  assign #(in_delay) CFGERRPOSTEDN_INDELAY = CFGERRPOSTEDN_IN;
  assign #(in_delay) CFGERRTLPCPLHEADER_INDELAY = CFGERRTLPCPLHEADER_IN;
  assign #(in_delay) CFGERRURN_INDELAY = CFGERRURN_IN;
  assign #(in_delay) CFGINTERRUPTASSERTN_INDELAY = CFGINTERRUPTASSERTN_IN;
  assign #(in_delay) CFGINTERRUPTDI_INDELAY = CFGINTERRUPTDI_IN;
  assign #(in_delay) CFGINTERRUPTN_INDELAY = CFGINTERRUPTN_IN;
  assign #(in_delay) CFGPMWAKEN_INDELAY = CFGPMWAKEN_IN;
  assign #(in_delay) CFGRDENN_INDELAY = CFGRDENN_IN;
  assign #(in_delay) CFGREVID_INDELAY = CFGREVID_IN;
  assign #(in_delay) CFGSUBSYSID_INDELAY = CFGSUBSYSID_IN;
  assign #(in_delay) CFGSUBSYSVENID_INDELAY = CFGSUBSYSVENID_IN;
  assign #(in_delay) CFGTRNPENDINGN_INDELAY = CFGTRNPENDINGN_IN;
  assign #(in_delay) CFGTURNOFFOKN_INDELAY = CFGTURNOFFOKN_IN;
  assign #(in_delay) CFGVENID_INDELAY = CFGVENID_IN;
  assign #(in_delay) CLOCKLOCKED_INDELAY = CLOCKLOCKED_IN;
  assign #(in_delay) MIMRXRDATA_INDELAY = MIMRXRDATA_IN;
  assign #(in_delay) MIMTXRDATA_INDELAY = MIMTXRDATA_IN;
  assign #(in_delay) PIPEGTRESETDONEA_INDELAY = PIPEGTRESETDONEA_IN;
  assign #(in_delay) PIPEGTRESETDONEB_INDELAY = PIPEGTRESETDONEB_IN;
  assign #(in_delay) PIPEPHYSTATUSA_INDELAY = PIPEPHYSTATUSA_IN;
  assign #(in_delay) PIPEPHYSTATUSB_INDELAY = PIPEPHYSTATUSB_IN;
  assign #(in_delay) PIPERXCHARISKA_INDELAY = PIPERXCHARISKA_IN;
  assign #(in_delay) PIPERXCHARISKB_INDELAY = PIPERXCHARISKB_IN;
  assign #(in_delay) PIPERXDATAA_INDELAY = PIPERXDATAA_IN;
  assign #(in_delay) PIPERXDATAB_INDELAY = PIPERXDATAB_IN;
  assign #(in_delay) PIPERXENTERELECIDLEA_INDELAY = PIPERXENTERELECIDLEA_IN;
  assign #(in_delay) PIPERXENTERELECIDLEB_INDELAY = PIPERXENTERELECIDLEB_IN;
  assign #(in_delay) PIPERXSTATUSA_INDELAY = PIPERXSTATUSA_IN;
  assign #(in_delay) PIPERXSTATUSB_INDELAY = PIPERXSTATUSB_IN;
  assign #(in_delay) SYSRESETN_INDELAY = SYSRESETN_IN;
  assign #(in_delay) TRNFCSEL_INDELAY = TRNFCSEL_IN;
  assign #(in_delay) TRNRDSTRDYN_INDELAY = TRNRDSTRDYN_IN;
  assign #(in_delay) TRNRNPOKN_INDELAY = TRNRNPOKN_IN;
  assign #(in_delay) TRNTCFGGNTN_INDELAY = TRNTCFGGNTN_IN;
  assign #(in_delay) TRNTD_INDELAY = TRNTD_IN;
  assign #(in_delay) TRNTEOFN_INDELAY = TRNTEOFN_IN;
  assign #(in_delay) TRNTERRFWDN_INDELAY = TRNTERRFWDN_IN;
  assign #(in_delay) TRNTSOFN_INDELAY = TRNTSOFN_IN;
  assign #(in_delay) TRNTSRCDSCN_INDELAY = TRNTSRCDSCN_IN;
  assign #(in_delay) TRNTSRCRDYN_INDELAY = TRNTSRCRDYN_IN;
  assign #(in_delay) TRNTSTRN_INDELAY = TRNTSTRN_IN;

  B_PCIE_A1 #(
    .BAR0 (BAR0),
    .BAR1 (BAR1),
    .BAR2 (BAR2),
    .BAR3 (BAR3),
    .BAR4 (BAR4),
    .BAR5 (BAR5),
    .CARDBUS_CIS_POINTER (CARDBUS_CIS_POINTER),
    .CLASS_CODE (CLASS_CODE),
    .DEV_CAP_ENDPOINT_L0S_LATENCY (DEV_CAP_ENDPOINT_L0S_LATENCY),
    .DEV_CAP_ENDPOINT_L1_LATENCY (DEV_CAP_ENDPOINT_L1_LATENCY),
    .DEV_CAP_EXT_TAG_SUPPORTED (DEV_CAP_EXT_TAG_SUPPORTED),
    .DEV_CAP_MAX_PAYLOAD_SUPPORTED (DEV_CAP_MAX_PAYLOAD_SUPPORTED),
    .DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT (DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT),
    .DEV_CAP_ROLE_BASED_ERROR (DEV_CAP_ROLE_BASED_ERROR),
    .DISABLE_BAR_FILTERING (DISABLE_BAR_FILTERING),
    .DISABLE_ID_CHECK (DISABLE_ID_CHECK),
    .DISABLE_SCRAMBLING (DISABLE_SCRAMBLING),
    .ENABLE_RX_TD_ECRC_TRIM (ENABLE_RX_TD_ECRC_TRIM),
    .EXPANSION_ROM (EXPANSION_ROM),
    .FAST_TRAIN (FAST_TRAIN),
    .GTP_SEL (GTP_SEL),
    .LINK_CAP_ASPM_SUPPORT (LINK_CAP_ASPM_SUPPORT),
    .LINK_CAP_L0S_EXIT_LATENCY (LINK_CAP_L0S_EXIT_LATENCY),
    .LINK_CAP_L1_EXIT_LATENCY (LINK_CAP_L1_EXIT_LATENCY),
    .LINK_STATUS_SLOT_CLOCK_CONFIG (LINK_STATUS_SLOT_CLOCK_CONFIG),
    .LL_ACK_TIMEOUT (LL_ACK_TIMEOUT),
    .LL_ACK_TIMEOUT_EN (LL_ACK_TIMEOUT_EN),
    .LL_REPLAY_TIMEOUT (LL_REPLAY_TIMEOUT),
    .LL_REPLAY_TIMEOUT_EN (LL_REPLAY_TIMEOUT_EN),
    .MSI_CAP_MULTIMSGCAP (MSI_CAP_MULTIMSGCAP),
    .MSI_CAP_MULTIMSG_EXTENSION (MSI_CAP_MULTIMSG_EXTENSION),
    .PCIE_CAP_CAPABILITY_VERSION (PCIE_CAP_CAPABILITY_VERSION),
    .PCIE_CAP_DEVICE_PORT_TYPE (PCIE_CAP_DEVICE_PORT_TYPE),
    .PCIE_CAP_INT_MSG_NUM (PCIE_CAP_INT_MSG_NUM),
    .PCIE_CAP_SLOT_IMPLEMENTED (PCIE_CAP_SLOT_IMPLEMENTED),
    .PCIE_GENERIC (PCIE_GENERIC),
    .PLM_AUTO_CONFIG (PLM_AUTO_CONFIG),
    .PM_CAP_AUXCURRENT (PM_CAP_AUXCURRENT),
    .PM_CAP_D1SUPPORT (PM_CAP_D1SUPPORT),
    .PM_CAP_D2SUPPORT (PM_CAP_D2SUPPORT),
    .PM_CAP_DSI (PM_CAP_DSI),
    .PM_CAP_PMESUPPORT (PM_CAP_PMESUPPORT),
    .PM_CAP_PME_CLOCK (PM_CAP_PME_CLOCK),
    .PM_CAP_VERSION (PM_CAP_VERSION),
    .PM_DATA0 (PM_DATA0),
    .PM_DATA1 (PM_DATA1),
    .PM_DATA2 (PM_DATA2),
    .PM_DATA3 (PM_DATA3),
    .PM_DATA4 (PM_DATA4),
    .PM_DATA5 (PM_DATA5),
    .PM_DATA6 (PM_DATA6),
    .PM_DATA7 (PM_DATA7),
    .PM_DATA_SCALE0 (PM_DATA_SCALE0),
    .PM_DATA_SCALE1 (PM_DATA_SCALE1),
    .PM_DATA_SCALE2 (PM_DATA_SCALE2),
    .PM_DATA_SCALE3 (PM_DATA_SCALE3),
    .PM_DATA_SCALE4 (PM_DATA_SCALE4),
    .PM_DATA_SCALE5 (PM_DATA_SCALE5),
    .PM_DATA_SCALE6 (PM_DATA_SCALE6),
    .PM_DATA_SCALE7 (PM_DATA_SCALE7),
    .SIM_VERSION (SIM_VERSION),
    .SLOT_CAP_ATT_BUTTON_PRESENT (SLOT_CAP_ATT_BUTTON_PRESENT),
    .SLOT_CAP_ATT_INDICATOR_PRESENT (SLOT_CAP_ATT_INDICATOR_PRESENT),
    .SLOT_CAP_POWER_INDICATOR_PRESENT (SLOT_CAP_POWER_INDICATOR_PRESENT),
    .TL_RX_RAM_RADDR_LATENCY (TL_RX_RAM_RADDR_LATENCY),
    .TL_RX_RAM_RDATA_LATENCY (TL_RX_RAM_RDATA_LATENCY),
    .TL_RX_RAM_WRITE_LATENCY (TL_RX_RAM_WRITE_LATENCY),
    .TL_TFC_DISABLE (TL_TFC_DISABLE),
    .TL_TX_CHECKS_DISABLE (TL_TX_CHECKS_DISABLE),
    .TL_TX_RAM_RADDR_LATENCY (TL_TX_RAM_RADDR_LATENCY),
    .TL_TX_RAM_RDATA_LATENCY (TL_TX_RAM_RDATA_LATENCY),
    .USR_CFG (USR_CFG),
    .USR_EXT_CFG (USR_EXT_CFG),
    .VC0_CPL_INFINITE (VC0_CPL_INFINITE),
    .VC0_RX_RAM_LIMIT (VC0_RX_RAM_LIMIT),
    .VC0_TOTAL_CREDITS_CD (VC0_TOTAL_CREDITS_CD),
    .VC0_TOTAL_CREDITS_CH (VC0_TOTAL_CREDITS_CH),
    .VC0_TOTAL_CREDITS_NPH (VC0_TOTAL_CREDITS_NPH),
    .VC0_TOTAL_CREDITS_PD (VC0_TOTAL_CREDITS_PD),
    .VC0_TOTAL_CREDITS_PH (VC0_TOTAL_CREDITS_PH),
    .VC0_TX_LASTPACKET (VC0_TX_LASTPACKET))

    B_PCIE_A1_INST (
    .GSR  (GSR),
    .CFGBUSNUMBER (CFGBUSNUMBER_OUT),
    .CFGCOMMANDBUSMASTERENABLE (CFGCOMMANDBUSMASTERENABLE_OUT),
    .CFGCOMMANDINTERRUPTDISABLE (CFGCOMMANDINTERRUPTDISABLE_OUT),
    .CFGCOMMANDIOENABLE (CFGCOMMANDIOENABLE_OUT),
    .CFGCOMMANDMEMENABLE (CFGCOMMANDMEMENABLE_OUT),
    .CFGCOMMANDSERREN (CFGCOMMANDSERREN_OUT),
    .CFGDEVCONTROLAUXPOWEREN (CFGDEVCONTROLAUXPOWEREN_OUT),
    .CFGDEVCONTROLCORRERRREPORTINGEN (CFGDEVCONTROLCORRERRREPORTINGEN_OUT),
    .CFGDEVCONTROLENABLERO (CFGDEVCONTROLENABLERO_OUT),
    .CFGDEVCONTROLEXTTAGEN (CFGDEVCONTROLEXTTAGEN_OUT),
    .CFGDEVCONTROLFATALERRREPORTINGEN (CFGDEVCONTROLFATALERRREPORTINGEN_OUT),
    .CFGDEVCONTROLMAXPAYLOAD (CFGDEVCONTROLMAXPAYLOAD_OUT),
    .CFGDEVCONTROLMAXREADREQ (CFGDEVCONTROLMAXREADREQ_OUT),
    .CFGDEVCONTROLNONFATALREPORTINGEN (CFGDEVCONTROLNONFATALREPORTINGEN_OUT),
    .CFGDEVCONTROLNOSNOOPEN (CFGDEVCONTROLNOSNOOPEN_OUT),
    .CFGDEVCONTROLPHANTOMEN (CFGDEVCONTROLPHANTOMEN_OUT),
    .CFGDEVCONTROLURERRREPORTINGEN (CFGDEVCONTROLURERRREPORTINGEN_OUT),
    .CFGDEVICENUMBER (CFGDEVICENUMBER_OUT),
    .CFGDEVSTATUSCORRERRDETECTED (CFGDEVSTATUSCORRERRDETECTED_OUT),
    .CFGDEVSTATUSFATALERRDETECTED (CFGDEVSTATUSFATALERRDETECTED_OUT),
    .CFGDEVSTATUSNONFATALERRDETECTED (CFGDEVSTATUSNONFATALERRDETECTED_OUT),
    .CFGDEVSTATUSURDETECTED (CFGDEVSTATUSURDETECTED_OUT),
    .CFGDO (CFGDO_OUT),
    .CFGERRCPLRDYN (CFGERRCPLRDYN_OUT),
    .CFGFUNCTIONNUMBER (CFGFUNCTIONNUMBER_OUT),
    .CFGINTERRUPTDO (CFGINTERRUPTDO_OUT),
    .CFGINTERRUPTMMENABLE (CFGINTERRUPTMMENABLE_OUT),
    .CFGINTERRUPTMSIENABLE (CFGINTERRUPTMSIENABLE_OUT),
    .CFGINTERRUPTRDYN (CFGINTERRUPTRDYN_OUT),
    .CFGLINKCONTOLRCB (CFGLINKCONTOLRCB_OUT),
    .CFGLINKCONTROLASPMCONTROL (CFGLINKCONTROLASPMCONTROL_OUT),
    .CFGLINKCONTROLCOMMONCLOCK (CFGLINKCONTROLCOMMONCLOCK_OUT),
    .CFGLINKCONTROLEXTENDEDSYNC (CFGLINKCONTROLEXTENDEDSYNC_OUT),
    .CFGLTSSMSTATE (CFGLTSSMSTATE_OUT),
    .CFGPCIELINKSTATEN (CFGPCIELINKSTATEN_OUT),
    .CFGRDWRDONEN (CFGRDWRDONEN_OUT),
    .CFGTOTURNOFFN (CFGTOTURNOFFN_OUT),
    .DBGBADDLLPSTATUS (DBGBADDLLPSTATUS_OUT),
    .DBGBADTLPLCRC (DBGBADTLPLCRC_OUT),
    .DBGBADTLPSEQNUM (DBGBADTLPSEQNUM_OUT),
    .DBGBADTLPSTATUS (DBGBADTLPSTATUS_OUT),
    .DBGDLPROTOCOLSTATUS (DBGDLPROTOCOLSTATUS_OUT),
    .DBGFCPROTOCOLERRSTATUS (DBGFCPROTOCOLERRSTATUS_OUT),
    .DBGMLFRMDLENGTH (DBGMLFRMDLENGTH_OUT),
    .DBGMLFRMDMPS (DBGMLFRMDMPS_OUT),
    .DBGMLFRMDTCVC (DBGMLFRMDTCVC_OUT),
    .DBGMLFRMDTLPSTATUS (DBGMLFRMDTLPSTATUS_OUT),
    .DBGMLFRMDUNRECTYPE (DBGMLFRMDUNRECTYPE_OUT),
    .DBGPOISTLPSTATUS (DBGPOISTLPSTATUS_OUT),
    .DBGRCVROVERFLOWSTATUS (DBGRCVROVERFLOWSTATUS_OUT),
    .DBGREGDETECTEDCORRECTABLE (DBGREGDETECTEDCORRECTABLE_OUT),
    .DBGREGDETECTEDFATAL (DBGREGDETECTEDFATAL_OUT),
    .DBGREGDETECTEDNONFATAL (DBGREGDETECTEDNONFATAL_OUT),
    .DBGREGDETECTEDUNSUPPORTED (DBGREGDETECTEDUNSUPPORTED_OUT),
    .DBGRPLYROLLOVERSTATUS (DBGRPLYROLLOVERSTATUS_OUT),
    .DBGRPLYTIMEOUTSTATUS (DBGRPLYTIMEOUTSTATUS_OUT),
    .DBGURNOBARHIT (DBGURNOBARHIT_OUT),
    .DBGURPOISCFGWR (DBGURPOISCFGWR_OUT),
    .DBGURSTATUS (DBGURSTATUS_OUT),
    .DBGURUNSUPMSG (DBGURUNSUPMSG_OUT),
    .MIMRXRADDR (MIMRXRADDR_OUT),
    .MIMRXREN (MIMRXREN_OUT),
    .MIMRXWADDR (MIMRXWADDR_OUT),
    .MIMRXWDATA (MIMRXWDATA_OUT),
    .MIMRXWEN (MIMRXWEN_OUT),
    .MIMTXRADDR (MIMTXRADDR_OUT),
    .MIMTXREN (MIMTXREN_OUT),
    .MIMTXWADDR (MIMTXWADDR_OUT),
    .MIMTXWDATA (MIMTXWDATA_OUT),
    .MIMTXWEN (MIMTXWEN_OUT),
    .PIPEGTPOWERDOWNA (PIPEGTPOWERDOWNA_OUT),
    .PIPEGTPOWERDOWNB (PIPEGTPOWERDOWNB_OUT),
    .PIPEGTTXELECIDLEA (PIPEGTTXELECIDLEA_OUT),
    .PIPEGTTXELECIDLEB (PIPEGTTXELECIDLEB_OUT),
    .PIPERXPOLARITYA (PIPERXPOLARITYA_OUT),
    .PIPERXPOLARITYB (PIPERXPOLARITYB_OUT),
    .PIPERXRESETA (PIPERXRESETA_OUT),
    .PIPERXRESETB (PIPERXRESETB_OUT),
    .PIPETXCHARDISPMODEA (PIPETXCHARDISPMODEA_OUT),
    .PIPETXCHARDISPMODEB (PIPETXCHARDISPMODEB_OUT),
    .PIPETXCHARDISPVALA (PIPETXCHARDISPVALA_OUT),
    .PIPETXCHARDISPVALB (PIPETXCHARDISPVALB_OUT),
    .PIPETXCHARISKA (PIPETXCHARISKA_OUT),
    .PIPETXCHARISKB (PIPETXCHARISKB_OUT),
    .PIPETXDATAA (PIPETXDATAA_OUT),
    .PIPETXDATAB (PIPETXDATAB_OUT),
    .PIPETXRCVRDETA (PIPETXRCVRDETA_OUT),
    .PIPETXRCVRDETB (PIPETXRCVRDETB_OUT),
    .RECEIVEDHOTRESET (RECEIVEDHOTRESET_OUT),
    .TRNFCCPLD (TRNFCCPLD_OUT),
    .TRNFCCPLH (TRNFCCPLH_OUT),
    .TRNFCNPD (TRNFCNPD_OUT),
    .TRNFCNPH (TRNFCNPH_OUT),
    .TRNFCPD (TRNFCPD_OUT),
    .TRNFCPH (TRNFCPH_OUT),
    .TRNLNKUPN (TRNLNKUPN_OUT),
    .TRNRBARHITN (TRNRBARHITN_OUT),
    .TRNRD (TRNRD_OUT),
    .TRNREOFN (TRNREOFN_OUT),
    .TRNRERRFWDN (TRNRERRFWDN_OUT),
    .TRNRSOFN (TRNRSOFN_OUT),
    .TRNRSRCDSCN (TRNRSRCDSCN_OUT),
    .TRNRSRCRDYN (TRNRSRCRDYN_OUT),
    .TRNTBUFAV (TRNTBUFAV_OUT),
    .TRNTCFGREQN (TRNTCFGREQN_OUT),
    .TRNTDSTRDYN (TRNTDSTRDYN_OUT),
    .TRNTERRDROPN (TRNTERRDROPN_OUT),
    .USERRSTN (USERRSTN_OUT),
    .CFGDEVID (CFGDEVID_INDELAY),
    .CFGDSN (CFGDSN_INDELAY),
    .CFGDWADDR (CFGDWADDR_INDELAY),
    .CFGERRCORN (CFGERRCORN_INDELAY),
    .CFGERRCPLABORTN (CFGERRCPLABORTN_INDELAY),
    .CFGERRCPLTIMEOUTN (CFGERRCPLTIMEOUTN_INDELAY),
    .CFGERRECRCN (CFGERRECRCN_INDELAY),
    .CFGERRLOCKEDN (CFGERRLOCKEDN_INDELAY),
    .CFGERRPOSTEDN (CFGERRPOSTEDN_INDELAY),
    .CFGERRTLPCPLHEADER (CFGERRTLPCPLHEADER_INDELAY),
    .CFGERRURN (CFGERRURN_INDELAY),
    .CFGINTERRUPTASSERTN (CFGINTERRUPTASSERTN_INDELAY),
    .CFGINTERRUPTDI (CFGINTERRUPTDI_INDELAY),
    .CFGINTERRUPTN (CFGINTERRUPTN_INDELAY),
    .CFGPMWAKEN (CFGPMWAKEN_INDELAY),
    .CFGRDENN (CFGRDENN_INDELAY),
    .CFGREVID (CFGREVID_INDELAY),
    .CFGSUBSYSID (CFGSUBSYSID_INDELAY),
    .CFGSUBSYSVENID (CFGSUBSYSVENID_INDELAY),
    .CFGTRNPENDINGN (CFGTRNPENDINGN_INDELAY),
    .CFGTURNOFFOKN (CFGTURNOFFOKN_INDELAY),
    .CFGVENID (CFGVENID_INDELAY),
    .CLOCKLOCKED (CLOCKLOCKED_INDELAY),
    .MGTCLK (MGTCLK_INDELAY),
    .MIMRXRDATA (MIMRXRDATA_INDELAY),
    .MIMTXRDATA (MIMTXRDATA_INDELAY),
    .PIPEGTRESETDONEA (PIPEGTRESETDONEA_INDELAY),
    .PIPEGTRESETDONEB (PIPEGTRESETDONEB_INDELAY),
    .PIPEPHYSTATUSA (PIPEPHYSTATUSA_INDELAY),
    .PIPEPHYSTATUSB (PIPEPHYSTATUSB_INDELAY),
    .PIPERXCHARISKA (PIPERXCHARISKA_INDELAY),
    .PIPERXCHARISKB (PIPERXCHARISKB_INDELAY),
    .PIPERXDATAA (PIPERXDATAA_INDELAY),
    .PIPERXDATAB (PIPERXDATAB_INDELAY),
    .PIPERXENTERELECIDLEA (PIPERXENTERELECIDLEA_INDELAY),
    .PIPERXENTERELECIDLEB (PIPERXENTERELECIDLEB_INDELAY),
    .PIPERXSTATUSA (PIPERXSTATUSA_INDELAY),
    .PIPERXSTATUSB (PIPERXSTATUSB_INDELAY),
    .SYSRESETN (SYSRESETN_INDELAY),
    .TRNFCSEL (TRNFCSEL_INDELAY),
    .TRNRDSTRDYN (TRNRDSTRDYN_INDELAY),
    .TRNRNPOKN (TRNRNPOKN_INDELAY),
    .TRNTCFGGNTN (TRNTCFGGNTN_INDELAY),
    .TRNTD (TRNTD_INDELAY),
    .TRNTEOFN (TRNTEOFN_INDELAY),
    .TRNTERRFWDN (TRNTERRFWDN_INDELAY),
    .TRNTSOFN (TRNTSOFN_INDELAY),
    .TRNTSRCDSCN (TRNTSRCDSCN_INDELAY),
    .TRNTSRCRDYN (TRNTSRCRDYN_INDELAY),
    .TRNTSTRN (TRNTSTRN_INDELAY),
    .USERCLK (USERCLK_INDELAY)
  );


  specify
    specparam PATHPULSE$ = 0;
    $period (posedge MGTCLK, 0:0:0, notifier);
    $period (posedge USERCLK, 0:0:0, notifier);
    $setuphold (posedge MGTCLK, negedge PIPEGTRESETDONEA, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEGTRESETDONEA_IN);
    $setuphold (posedge MGTCLK, negedge PIPEGTRESETDONEB, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEGTRESETDONEB_IN);
    $setuphold (posedge MGTCLK, negedge PIPEPHYSTATUSA, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEPHYSTATUSA_IN);
    $setuphold (posedge MGTCLK, negedge PIPEPHYSTATUSB, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEPHYSTATUSB_IN);
    $setuphold (posedge MGTCLK, negedge PIPERXCHARISKA[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKA_IN[0]);
    $setuphold (posedge MGTCLK, negedge PIPERXCHARISKA[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKA_IN[1]);
    $setuphold (posedge MGTCLK, negedge PIPERXCHARISKB[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKB_IN[0]);
    $setuphold (posedge MGTCLK, negedge PIPERXCHARISKB[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKB_IN[1]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[0]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[10], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[10]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[11], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[11]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[12], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[12]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[13], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[13]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[14], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[14]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[15], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[15]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[1]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[2]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[3], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[3]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[4], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[4]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[5], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[5]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[6], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[6]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[7], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[7]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[8], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[8]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAA[9], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[9]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[0]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[10], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[10]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[11], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[11]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[12], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[12]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[13], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[13]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[14], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[14]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[15], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[15]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[1]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[2]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[3], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[3]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[4], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[4]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[5], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[5]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[6], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[6]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[7], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[7]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[8], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[8]);
    $setuphold (posedge MGTCLK, negedge PIPERXDATAB[9], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[9]);
    $setuphold (posedge MGTCLK, negedge PIPERXENTERELECIDLEA, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXENTERELECIDLEA_IN);
    $setuphold (posedge MGTCLK, negedge PIPERXENTERELECIDLEB, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXENTERELECIDLEB_IN);
    $setuphold (posedge MGTCLK, negedge PIPERXSTATUSA[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSA_IN[0]);
    $setuphold (posedge MGTCLK, negedge PIPERXSTATUSA[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSA_IN[1]);
    $setuphold (posedge MGTCLK, negedge PIPERXSTATUSA[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSA_IN[2]);
    $setuphold (posedge MGTCLK, negedge PIPERXSTATUSB[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSB_IN[0]);
    $setuphold (posedge MGTCLK, negedge PIPERXSTATUSB[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSB_IN[1]);
    $setuphold (posedge MGTCLK, negedge PIPERXSTATUSB[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSB_IN[2]);
    $setuphold (posedge MGTCLK, posedge PIPEGTRESETDONEA, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEGTRESETDONEA_IN);
    $setuphold (posedge MGTCLK, posedge PIPEGTRESETDONEB, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEGTRESETDONEB_IN);
    $setuphold (posedge MGTCLK, posedge PIPEPHYSTATUSA, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEPHYSTATUSA_IN);
    $setuphold (posedge MGTCLK, posedge PIPEPHYSTATUSB, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPEPHYSTATUSB_IN);
    $setuphold (posedge MGTCLK, posedge PIPERXCHARISKA[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKA_IN[0]);
    $setuphold (posedge MGTCLK, posedge PIPERXCHARISKA[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKA_IN[1]);
    $setuphold (posedge MGTCLK, posedge PIPERXCHARISKB[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKB_IN[0]);
    $setuphold (posedge MGTCLK, posedge PIPERXCHARISKB[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXCHARISKB_IN[1]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[0]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[10], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[10]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[11], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[11]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[12], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[12]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[13], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[13]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[14], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[14]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[15], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[15]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[1]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[2]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[3], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[3]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[4], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[4]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[5], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[5]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[6], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[6]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[7], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[7]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[8], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[8]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAA[9], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAA_IN[9]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[0]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[10], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[10]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[11], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[11]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[12], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[12]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[13], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[13]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[14], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[14]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[15], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[15]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[1]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[2]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[3], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[3]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[4], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[4]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[5], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[5]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[6], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[6]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[7], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[7]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[8], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[8]);
    $setuphold (posedge MGTCLK, posedge PIPERXDATAB[9], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXDATAB_IN[9]);
    $setuphold (posedge MGTCLK, posedge PIPERXENTERELECIDLEA, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXENTERELECIDLEA_IN);
    $setuphold (posedge MGTCLK, posedge PIPERXENTERELECIDLEB, 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXENTERELECIDLEB_IN);
    $setuphold (posedge MGTCLK, posedge PIPERXSTATUSA[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSA_IN[0]);
    $setuphold (posedge MGTCLK, posedge PIPERXSTATUSA[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSA_IN[1]);
    $setuphold (posedge MGTCLK, posedge PIPERXSTATUSA[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSA_IN[2]);
    $setuphold (posedge MGTCLK, posedge PIPERXSTATUSB[0], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSB_IN[0]);
    $setuphold (posedge MGTCLK, posedge PIPERXSTATUSB[1], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSB_IN[1]);
    $setuphold (posedge MGTCLK, posedge PIPERXSTATUSB[2], 0:0:0, 0:0:0, notifier,,, MGTCLK_IN, PIPERXSTATUSB_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[10]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[11]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[12]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[13]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[14]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[15]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGDEVID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[9]);
    $setuphold (posedge USERCLK, negedge CFGDSN[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGDSN[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[10]);
    $setuphold (posedge USERCLK, negedge CFGDSN[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[11]);
    $setuphold (posedge USERCLK, negedge CFGDSN[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[12]);
    $setuphold (posedge USERCLK, negedge CFGDSN[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[13]);
    $setuphold (posedge USERCLK, negedge CFGDSN[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[14]);
    $setuphold (posedge USERCLK, negedge CFGDSN[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[15]);
    $setuphold (posedge USERCLK, negedge CFGDSN[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[16]);
    $setuphold (posedge USERCLK, negedge CFGDSN[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[17]);
    $setuphold (posedge USERCLK, negedge CFGDSN[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[18]);
    $setuphold (posedge USERCLK, negedge CFGDSN[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[19]);
    $setuphold (posedge USERCLK, negedge CFGDSN[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGDSN[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[20]);
    $setuphold (posedge USERCLK, negedge CFGDSN[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[21]);
    $setuphold (posedge USERCLK, negedge CFGDSN[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[22]);
    $setuphold (posedge USERCLK, negedge CFGDSN[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[23]);
    $setuphold (posedge USERCLK, negedge CFGDSN[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[24]);
    $setuphold (posedge USERCLK, negedge CFGDSN[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[25]);
    $setuphold (posedge USERCLK, negedge CFGDSN[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[26]);
    $setuphold (posedge USERCLK, negedge CFGDSN[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[27]);
    $setuphold (posedge USERCLK, negedge CFGDSN[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[28]);
    $setuphold (posedge USERCLK, negedge CFGDSN[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[29]);
    $setuphold (posedge USERCLK, negedge CFGDSN[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGDSN[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[30]);
    $setuphold (posedge USERCLK, negedge CFGDSN[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[31]);
    $setuphold (posedge USERCLK, negedge CFGDSN[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[32]);
    $setuphold (posedge USERCLK, negedge CFGDSN[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[33]);
    $setuphold (posedge USERCLK, negedge CFGDSN[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[34]);
    $setuphold (posedge USERCLK, negedge CFGDSN[35], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[35]);
    $setuphold (posedge USERCLK, negedge CFGDSN[36], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[36]);
    $setuphold (posedge USERCLK, negedge CFGDSN[37], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[37]);
    $setuphold (posedge USERCLK, negedge CFGDSN[38], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[38]);
    $setuphold (posedge USERCLK, negedge CFGDSN[39], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[39]);
    $setuphold (posedge USERCLK, negedge CFGDSN[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGDSN[40], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[40]);
    $setuphold (posedge USERCLK, negedge CFGDSN[41], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[41]);
    $setuphold (posedge USERCLK, negedge CFGDSN[42], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[42]);
    $setuphold (posedge USERCLK, negedge CFGDSN[43], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[43]);
    $setuphold (posedge USERCLK, negedge CFGDSN[44], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[44]);
    $setuphold (posedge USERCLK, negedge CFGDSN[45], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[45]);
    $setuphold (posedge USERCLK, negedge CFGDSN[46], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[46]);
    $setuphold (posedge USERCLK, negedge CFGDSN[47], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[47]);
    $setuphold (posedge USERCLK, negedge CFGDSN[48], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[48]);
    $setuphold (posedge USERCLK, negedge CFGDSN[49], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[49]);
    $setuphold (posedge USERCLK, negedge CFGDSN[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGDSN[50], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[50]);
    $setuphold (posedge USERCLK, negedge CFGDSN[51], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[51]);
    $setuphold (posedge USERCLK, negedge CFGDSN[52], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[52]);
    $setuphold (posedge USERCLK, negedge CFGDSN[53], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[53]);
    $setuphold (posedge USERCLK, negedge CFGDSN[54], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[54]);
    $setuphold (posedge USERCLK, negedge CFGDSN[55], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[55]);
    $setuphold (posedge USERCLK, negedge CFGDSN[56], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[56]);
    $setuphold (posedge USERCLK, negedge CFGDSN[57], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[57]);
    $setuphold (posedge USERCLK, negedge CFGDSN[58], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[58]);
    $setuphold (posedge USERCLK, negedge CFGDSN[59], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[59]);
    $setuphold (posedge USERCLK, negedge CFGDSN[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGDSN[60], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[60]);
    $setuphold (posedge USERCLK, negedge CFGDSN[61], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[61]);
    $setuphold (posedge USERCLK, negedge CFGDSN[62], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[62]);
    $setuphold (posedge USERCLK, negedge CFGDSN[63], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[63]);
    $setuphold (posedge USERCLK, negedge CFGDSN[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGDSN[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGDSN[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGDSN[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[9]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGDWADDR[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[9]);
    $setuphold (posedge USERCLK, negedge CFGERRCORN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRCORN_IN);
    $setuphold (posedge USERCLK, negedge CFGERRCPLABORTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRCPLABORTN_IN);
    $setuphold (posedge USERCLK, negedge CFGERRCPLTIMEOUTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRCPLTIMEOUTN_IN);
    $setuphold (posedge USERCLK, negedge CFGERRECRCN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRECRCN_IN);
    $setuphold (posedge USERCLK, negedge CFGERRLOCKEDN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRLOCKEDN_IN);
    $setuphold (posedge USERCLK, negedge CFGERRPOSTEDN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRPOSTEDN_IN);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[10]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[11]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[12]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[13]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[14]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[15]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[16]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[17]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[18]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[19]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[20]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[21]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[22]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[23]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[24]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[25]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[26]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[27]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[28]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[29]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[30]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[31]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[32]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[33]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[34]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[35], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[35]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[36], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[36]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[37], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[37]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[38], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[38]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[39], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[39]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[40], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[40]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[41], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[41]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[42], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[42]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[43], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[43]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[44], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[44]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[45], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[45]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[46], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[46]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[47], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[47]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGERRTLPCPLHEADER[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[9]);
    $setuphold (posedge USERCLK, negedge CFGERRURN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRURN_IN);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTASSERTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTASSERTN_IN);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTDI[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGINTERRUPTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTN_IN);
    $setuphold (posedge USERCLK, negedge CFGPMWAKEN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGPMWAKEN_IN);
    $setuphold (posedge USERCLK, negedge CFGRDENN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGRDENN_IN);
    $setuphold (posedge USERCLK, negedge CFGREVID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGREVID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGREVID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGREVID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGREVID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGREVID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGREVID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGREVID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[10]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[11]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[12]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[13]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[14]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[15]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[9]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[10]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[11]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[12]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[13]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[14]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[15]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGSUBSYSVENID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[9]);
    $setuphold (posedge USERCLK, negedge CFGTRNPENDINGN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGTRNPENDINGN_IN);
    $setuphold (posedge USERCLK, negedge CFGTURNOFFOKN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGTURNOFFOKN_IN);
    $setuphold (posedge USERCLK, negedge CFGVENID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[0]);
    $setuphold (posedge USERCLK, negedge CFGVENID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[10]);
    $setuphold (posedge USERCLK, negedge CFGVENID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[11]);
    $setuphold (posedge USERCLK, negedge CFGVENID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[12]);
    $setuphold (posedge USERCLK, negedge CFGVENID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[13]);
    $setuphold (posedge USERCLK, negedge CFGVENID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[14]);
    $setuphold (posedge USERCLK, negedge CFGVENID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[15]);
    $setuphold (posedge USERCLK, negedge CFGVENID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[1]);
    $setuphold (posedge USERCLK, negedge CFGVENID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[2]);
    $setuphold (posedge USERCLK, negedge CFGVENID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[3]);
    $setuphold (posedge USERCLK, negedge CFGVENID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[4]);
    $setuphold (posedge USERCLK, negedge CFGVENID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[5]);
    $setuphold (posedge USERCLK, negedge CFGVENID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[6]);
    $setuphold (posedge USERCLK, negedge CFGVENID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[7]);
    $setuphold (posedge USERCLK, negedge CFGVENID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[8]);
    $setuphold (posedge USERCLK, negedge CFGVENID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[9]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[0]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[10]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[11]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[12]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[13]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[14]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[15]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[16]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[17]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[18]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[19]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[1]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[20]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[21]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[22]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[23]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[24]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[25]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[26]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[27]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[28]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[29]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[2]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[30]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[31]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[32]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[33]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[34]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[3]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[4]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[5]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[6]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[7]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[8]);
    $setuphold (posedge USERCLK, negedge MIMRXRDATA[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[9]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[0]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[10]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[11]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[12]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[13]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[14]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[15]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[16]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[17]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[18]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[19]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[1]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[20]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[21]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[22]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[23]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[24]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[25]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[26]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[27]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[28]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[29]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[2]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[30]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[31]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[32]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[33]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[34]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[35], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[35]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[3]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[4]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[5]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[6]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[7]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[8]);
    $setuphold (posedge USERCLK, negedge MIMTXRDATA[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[9]);
    $setuphold (posedge USERCLK, negedge TRNFCSEL[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNFCSEL_IN[0]);
    $setuphold (posedge USERCLK, negedge TRNFCSEL[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNFCSEL_IN[1]);
    $setuphold (posedge USERCLK, negedge TRNFCSEL[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNFCSEL_IN[2]);
    $setuphold (posedge USERCLK, negedge TRNRDSTRDYN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNRDSTRDYN_IN);
    $setuphold (posedge USERCLK, negedge TRNRNPOKN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNRNPOKN_IN);
    $setuphold (posedge USERCLK, negedge TRNTCFGGNTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTCFGGNTN_IN);
    $setuphold (posedge USERCLK, negedge TRNTD[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[0]);
    $setuphold (posedge USERCLK, negedge TRNTD[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[10]);
    $setuphold (posedge USERCLK, negedge TRNTD[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[11]);
    $setuphold (posedge USERCLK, negedge TRNTD[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[12]);
    $setuphold (posedge USERCLK, negedge TRNTD[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[13]);
    $setuphold (posedge USERCLK, negedge TRNTD[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[14]);
    $setuphold (posedge USERCLK, negedge TRNTD[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[15]);
    $setuphold (posedge USERCLK, negedge TRNTD[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[16]);
    $setuphold (posedge USERCLK, negedge TRNTD[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[17]);
    $setuphold (posedge USERCLK, negedge TRNTD[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[18]);
    $setuphold (posedge USERCLK, negedge TRNTD[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[19]);
    $setuphold (posedge USERCLK, negedge TRNTD[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[1]);
    $setuphold (posedge USERCLK, negedge TRNTD[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[20]);
    $setuphold (posedge USERCLK, negedge TRNTD[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[21]);
    $setuphold (posedge USERCLK, negedge TRNTD[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[22]);
    $setuphold (posedge USERCLK, negedge TRNTD[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[23]);
    $setuphold (posedge USERCLK, negedge TRNTD[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[24]);
    $setuphold (posedge USERCLK, negedge TRNTD[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[25]);
    $setuphold (posedge USERCLK, negedge TRNTD[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[26]);
    $setuphold (posedge USERCLK, negedge TRNTD[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[27]);
    $setuphold (posedge USERCLK, negedge TRNTD[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[28]);
    $setuphold (posedge USERCLK, negedge TRNTD[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[29]);
    $setuphold (posedge USERCLK, negedge TRNTD[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[2]);
    $setuphold (posedge USERCLK, negedge TRNTD[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[30]);
    $setuphold (posedge USERCLK, negedge TRNTD[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[31]);
    $setuphold (posedge USERCLK, negedge TRNTD[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[3]);
    $setuphold (posedge USERCLK, negedge TRNTD[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[4]);
    $setuphold (posedge USERCLK, negedge TRNTD[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[5]);
    $setuphold (posedge USERCLK, negedge TRNTD[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[6]);
    $setuphold (posedge USERCLK, negedge TRNTD[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[7]);
    $setuphold (posedge USERCLK, negedge TRNTD[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[8]);
    $setuphold (posedge USERCLK, negedge TRNTD[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[9]);
    $setuphold (posedge USERCLK, negedge TRNTEOFN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTEOFN_IN);
    $setuphold (posedge USERCLK, negedge TRNTERRFWDN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTERRFWDN_IN);
    $setuphold (posedge USERCLK, negedge TRNTSOFN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSOFN_IN);
    $setuphold (posedge USERCLK, negedge TRNTSRCDSCN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSRCDSCN_IN);
    $setuphold (posedge USERCLK, negedge TRNTSRCRDYN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSRCRDYN_IN);
    $setuphold (posedge USERCLK, negedge TRNTSTRN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSTRN_IN);
    $setuphold (posedge USERCLK, posedge CFGDEVID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[10]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[11]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[12]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[13]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[14]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[15]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGDEVID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDEVID_IN[9]);
    $setuphold (posedge USERCLK, posedge CFGDSN[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGDSN[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[10]);
    $setuphold (posedge USERCLK, posedge CFGDSN[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[11]);
    $setuphold (posedge USERCLK, posedge CFGDSN[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[12]);
    $setuphold (posedge USERCLK, posedge CFGDSN[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[13]);
    $setuphold (posedge USERCLK, posedge CFGDSN[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[14]);
    $setuphold (posedge USERCLK, posedge CFGDSN[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[15]);
    $setuphold (posedge USERCLK, posedge CFGDSN[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[16]);
    $setuphold (posedge USERCLK, posedge CFGDSN[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[17]);
    $setuphold (posedge USERCLK, posedge CFGDSN[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[18]);
    $setuphold (posedge USERCLK, posedge CFGDSN[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[19]);
    $setuphold (posedge USERCLK, posedge CFGDSN[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGDSN[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[20]);
    $setuphold (posedge USERCLK, posedge CFGDSN[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[21]);
    $setuphold (posedge USERCLK, posedge CFGDSN[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[22]);
    $setuphold (posedge USERCLK, posedge CFGDSN[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[23]);
    $setuphold (posedge USERCLK, posedge CFGDSN[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[24]);
    $setuphold (posedge USERCLK, posedge CFGDSN[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[25]);
    $setuphold (posedge USERCLK, posedge CFGDSN[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[26]);
    $setuphold (posedge USERCLK, posedge CFGDSN[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[27]);
    $setuphold (posedge USERCLK, posedge CFGDSN[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[28]);
    $setuphold (posedge USERCLK, posedge CFGDSN[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[29]);
    $setuphold (posedge USERCLK, posedge CFGDSN[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGDSN[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[30]);
    $setuphold (posedge USERCLK, posedge CFGDSN[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[31]);
    $setuphold (posedge USERCLK, posedge CFGDSN[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[32]);
    $setuphold (posedge USERCLK, posedge CFGDSN[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[33]);
    $setuphold (posedge USERCLK, posedge CFGDSN[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[34]);
    $setuphold (posedge USERCLK, posedge CFGDSN[35], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[35]);
    $setuphold (posedge USERCLK, posedge CFGDSN[36], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[36]);
    $setuphold (posedge USERCLK, posedge CFGDSN[37], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[37]);
    $setuphold (posedge USERCLK, posedge CFGDSN[38], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[38]);
    $setuphold (posedge USERCLK, posedge CFGDSN[39], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[39]);
    $setuphold (posedge USERCLK, posedge CFGDSN[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGDSN[40], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[40]);
    $setuphold (posedge USERCLK, posedge CFGDSN[41], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[41]);
    $setuphold (posedge USERCLK, posedge CFGDSN[42], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[42]);
    $setuphold (posedge USERCLK, posedge CFGDSN[43], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[43]);
    $setuphold (posedge USERCLK, posedge CFGDSN[44], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[44]);
    $setuphold (posedge USERCLK, posedge CFGDSN[45], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[45]);
    $setuphold (posedge USERCLK, posedge CFGDSN[46], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[46]);
    $setuphold (posedge USERCLK, posedge CFGDSN[47], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[47]);
    $setuphold (posedge USERCLK, posedge CFGDSN[48], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[48]);
    $setuphold (posedge USERCLK, posedge CFGDSN[49], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[49]);
    $setuphold (posedge USERCLK, posedge CFGDSN[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGDSN[50], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[50]);
    $setuphold (posedge USERCLK, posedge CFGDSN[51], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[51]);
    $setuphold (posedge USERCLK, posedge CFGDSN[52], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[52]);
    $setuphold (posedge USERCLK, posedge CFGDSN[53], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[53]);
    $setuphold (posedge USERCLK, posedge CFGDSN[54], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[54]);
    $setuphold (posedge USERCLK, posedge CFGDSN[55], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[55]);
    $setuphold (posedge USERCLK, posedge CFGDSN[56], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[56]);
    $setuphold (posedge USERCLK, posedge CFGDSN[57], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[57]);
    $setuphold (posedge USERCLK, posedge CFGDSN[58], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[58]);
    $setuphold (posedge USERCLK, posedge CFGDSN[59], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[59]);
    $setuphold (posedge USERCLK, posedge CFGDSN[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGDSN[60], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[60]);
    $setuphold (posedge USERCLK, posedge CFGDSN[61], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[61]);
    $setuphold (posedge USERCLK, posedge CFGDSN[62], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[62]);
    $setuphold (posedge USERCLK, posedge CFGDSN[63], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[63]);
    $setuphold (posedge USERCLK, posedge CFGDSN[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGDSN[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGDSN[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGDSN[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDSN_IN[9]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGDWADDR[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGDWADDR_IN[9]);
    $setuphold (posedge USERCLK, posedge CFGERRCORN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRCORN_IN);
    $setuphold (posedge USERCLK, posedge CFGERRCPLABORTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRCPLABORTN_IN);
    $setuphold (posedge USERCLK, posedge CFGERRCPLTIMEOUTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRCPLTIMEOUTN_IN);
    $setuphold (posedge USERCLK, posedge CFGERRECRCN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRECRCN_IN);
    $setuphold (posedge USERCLK, posedge CFGERRLOCKEDN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRLOCKEDN_IN);
    $setuphold (posedge USERCLK, posedge CFGERRPOSTEDN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRPOSTEDN_IN);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[10]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[11]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[12]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[13]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[14]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[15]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[16]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[17]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[18]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[19]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[20]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[21]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[22]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[23]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[24]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[25]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[26]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[27]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[28]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[29]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[30]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[31]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[32]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[33]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[34]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[35], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[35]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[36], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[36]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[37], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[37]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[38], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[38]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[39], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[39]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[40], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[40]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[41], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[41]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[42], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[42]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[43], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[43]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[44], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[44]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[45], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[45]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[46], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[46]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[47], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[47]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGERRTLPCPLHEADER[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRTLPCPLHEADER_IN[9]);
    $setuphold (posedge USERCLK, posedge CFGERRURN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGERRURN_IN);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTASSERTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTASSERTN_IN);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTDI[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTDI_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGINTERRUPTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGINTERRUPTN_IN);
    $setuphold (posedge USERCLK, posedge CFGPMWAKEN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGPMWAKEN_IN);
    $setuphold (posedge USERCLK, posedge CFGRDENN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGRDENN_IN);
    $setuphold (posedge USERCLK, posedge CFGREVID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGREVID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGREVID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGREVID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGREVID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGREVID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGREVID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGREVID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGREVID_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[10]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[11]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[12]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[13]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[14]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[15]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSID_IN[9]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[10]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[11]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[12]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[13]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[14]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[15]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGSUBSYSVENID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGSUBSYSVENID_IN[9]);
    $setuphold (posedge USERCLK, posedge CFGTRNPENDINGN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGTRNPENDINGN_IN);
    $setuphold (posedge USERCLK, posedge CFGTURNOFFOKN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGTURNOFFOKN_IN);
    $setuphold (posedge USERCLK, posedge CFGVENID[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[0]);
    $setuphold (posedge USERCLK, posedge CFGVENID[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[10]);
    $setuphold (posedge USERCLK, posedge CFGVENID[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[11]);
    $setuphold (posedge USERCLK, posedge CFGVENID[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[12]);
    $setuphold (posedge USERCLK, posedge CFGVENID[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[13]);
    $setuphold (posedge USERCLK, posedge CFGVENID[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[14]);
    $setuphold (posedge USERCLK, posedge CFGVENID[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[15]);
    $setuphold (posedge USERCLK, posedge CFGVENID[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[1]);
    $setuphold (posedge USERCLK, posedge CFGVENID[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[2]);
    $setuphold (posedge USERCLK, posedge CFGVENID[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[3]);
    $setuphold (posedge USERCLK, posedge CFGVENID[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[4]);
    $setuphold (posedge USERCLK, posedge CFGVENID[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[5]);
    $setuphold (posedge USERCLK, posedge CFGVENID[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[6]);
    $setuphold (posedge USERCLK, posedge CFGVENID[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[7]);
    $setuphold (posedge USERCLK, posedge CFGVENID[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[8]);
    $setuphold (posedge USERCLK, posedge CFGVENID[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, CFGVENID_IN[9]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[0]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[10]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[11]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[12]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[13]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[14]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[15]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[16]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[17]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[18]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[19]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[1]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[20]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[21]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[22]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[23]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[24]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[25]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[26]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[27]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[28]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[29]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[2]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[30]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[31]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[32]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[33]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[34]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[3]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[4]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[5]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[6]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[7]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[8]);
    $setuphold (posedge USERCLK, posedge MIMRXRDATA[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMRXRDATA_IN[9]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[0]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[10]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[11]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[12]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[13]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[14]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[15]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[16]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[17]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[18]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[19]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[1]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[20]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[21]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[22]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[23]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[24]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[25]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[26]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[27]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[28]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[29]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[2]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[30]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[31]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[32], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[32]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[33], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[33]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[34], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[34]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[35], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[35]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[3]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[4]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[5]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[6]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[7]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[8]);
    $setuphold (posedge USERCLK, posedge MIMTXRDATA[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, MIMTXRDATA_IN[9]);
    $setuphold (posedge USERCLK, posedge TRNFCSEL[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNFCSEL_IN[0]);
    $setuphold (posedge USERCLK, posedge TRNFCSEL[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNFCSEL_IN[1]);
    $setuphold (posedge USERCLK, posedge TRNFCSEL[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNFCSEL_IN[2]);
    $setuphold (posedge USERCLK, posedge TRNRDSTRDYN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNRDSTRDYN_IN);
    $setuphold (posedge USERCLK, posedge TRNRNPOKN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNRNPOKN_IN);
    $setuphold (posedge USERCLK, posedge TRNTCFGGNTN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTCFGGNTN_IN);
    $setuphold (posedge USERCLK, posedge TRNTD[0], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[0]);
    $setuphold (posedge USERCLK, posedge TRNTD[10], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[10]);
    $setuphold (posedge USERCLK, posedge TRNTD[11], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[11]);
    $setuphold (posedge USERCLK, posedge TRNTD[12], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[12]);
    $setuphold (posedge USERCLK, posedge TRNTD[13], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[13]);
    $setuphold (posedge USERCLK, posedge TRNTD[14], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[14]);
    $setuphold (posedge USERCLK, posedge TRNTD[15], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[15]);
    $setuphold (posedge USERCLK, posedge TRNTD[16], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[16]);
    $setuphold (posedge USERCLK, posedge TRNTD[17], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[17]);
    $setuphold (posedge USERCLK, posedge TRNTD[18], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[18]);
    $setuphold (posedge USERCLK, posedge TRNTD[19], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[19]);
    $setuphold (posedge USERCLK, posedge TRNTD[1], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[1]);
    $setuphold (posedge USERCLK, posedge TRNTD[20], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[20]);
    $setuphold (posedge USERCLK, posedge TRNTD[21], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[21]);
    $setuphold (posedge USERCLK, posedge TRNTD[22], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[22]);
    $setuphold (posedge USERCLK, posedge TRNTD[23], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[23]);
    $setuphold (posedge USERCLK, posedge TRNTD[24], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[24]);
    $setuphold (posedge USERCLK, posedge TRNTD[25], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[25]);
    $setuphold (posedge USERCLK, posedge TRNTD[26], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[26]);
    $setuphold (posedge USERCLK, posedge TRNTD[27], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[27]);
    $setuphold (posedge USERCLK, posedge TRNTD[28], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[28]);
    $setuphold (posedge USERCLK, posedge TRNTD[29], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[29]);
    $setuphold (posedge USERCLK, posedge TRNTD[2], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[2]);
    $setuphold (posedge USERCLK, posedge TRNTD[30], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[30]);
    $setuphold (posedge USERCLK, posedge TRNTD[31], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[31]);
    $setuphold (posedge USERCLK, posedge TRNTD[3], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[3]);
    $setuphold (posedge USERCLK, posedge TRNTD[4], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[4]);
    $setuphold (posedge USERCLK, posedge TRNTD[5], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[5]);
    $setuphold (posedge USERCLK, posedge TRNTD[6], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[6]);
    $setuphold (posedge USERCLK, posedge TRNTD[7], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[7]);
    $setuphold (posedge USERCLK, posedge TRNTD[8], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[8]);
    $setuphold (posedge USERCLK, posedge TRNTD[9], 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTD_IN[9]);
    $setuphold (posedge USERCLK, posedge TRNTEOFN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTEOFN_IN);
    $setuphold (posedge USERCLK, posedge TRNTERRFWDN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTERRFWDN_IN);
    $setuphold (posedge USERCLK, posedge TRNTSOFN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSOFN_IN);
    $setuphold (posedge USERCLK, posedge TRNTSRCDSCN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSRCDSCN_IN);
    $setuphold (posedge USERCLK, posedge TRNTSRCRDYN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSRCRDYN_IN);
    $setuphold (posedge USERCLK, posedge TRNTSTRN, 0:0:0, 0:0:0, notifier,,, USERCLK_IN, TRNTSTRN_IN);

    ( MGTCLK => CFGLTSSMSTATE[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => CFGLTSSMSTATE[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => CFGLTSSMSTATE[2]) = (0:0:0, 0:0:0);
    ( MGTCLK => CFGLTSSMSTATE[3]) = (0:0:0, 0:0:0);
    ( MGTCLK => CFGLTSSMSTATE[4]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPEGTPOWERDOWNA[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPEGTPOWERDOWNA[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPEGTPOWERDOWNB[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPEGTPOWERDOWNB[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPEGTTXELECIDLEA) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPEGTTXELECIDLEB) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPERXPOLARITYA) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPERXPOLARITYB) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPERXRESETA) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPERXRESETB) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPMODEA[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPMODEA[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPMODEB[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPMODEB[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPVALA[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPVALA[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPVALB[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARDISPVALB[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARISKA[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARISKA[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARISKB[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXCHARISKB[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[10]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[11]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[12]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[13]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[14]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[15]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[2]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[3]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[4]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[5]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[6]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[7]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[8]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAA[9]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[0]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[10]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[11]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[12]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[13]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[14]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[15]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[1]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[2]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[3]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[4]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[5]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[6]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[7]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[8]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXDATAB[9]) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXRCVRDETA) = (0:0:0, 0:0:0);
    ( MGTCLK => PIPETXRCVRDETB) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[3]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[4]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[5]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[6]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGBUSNUMBER[7]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGCOMMANDBUSMASTERENABLE) = (0:0:0, 0:0:0);
    ( USERCLK => CFGCOMMANDINTERRUPTDISABLE) = (0:0:0, 0:0:0);
    ( USERCLK => CFGCOMMANDIOENABLE) = (0:0:0, 0:0:0);
    ( USERCLK => CFGCOMMANDMEMENABLE) = (0:0:0, 0:0:0);
    ( USERCLK => CFGCOMMANDSERREN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLAUXPOWEREN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLCORRERRREPORTINGEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLENABLERO) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLEXTTAGEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLFATALERRREPORTINGEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLMAXPAYLOAD[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLMAXPAYLOAD[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLMAXPAYLOAD[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLMAXREADREQ[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLMAXREADREQ[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLMAXREADREQ[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLNONFATALREPORTINGEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLNOSNOOPEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLPHANTOMEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVCONTROLURERRREPORTINGEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVICENUMBER[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVICENUMBER[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVICENUMBER[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVICENUMBER[3]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVICENUMBER[4]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVSTATUSCORRERRDETECTED) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVSTATUSFATALERRDETECTED) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVSTATUSNONFATALERRDETECTED) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDEVSTATUSURDETECTED) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[10]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[11]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[12]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[13]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[14]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[15]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[16]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[17]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[18]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[19]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[20]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[21]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[22]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[23]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[24]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[25]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[26]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[27]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[28]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[29]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[30]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[31]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[3]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[4]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[5]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[6]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[7]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[8]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGDO[9]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGERRCPLRDYN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGFUNCTIONNUMBER[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGFUNCTIONNUMBER[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGFUNCTIONNUMBER[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[3]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[4]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[5]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[6]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTDO[7]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTMMENABLE[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTMMENABLE[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTMMENABLE[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTMSIENABLE) = (0:0:0, 0:0:0);
    ( USERCLK => CFGINTERRUPTRDYN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGLINKCONTOLRCB) = (0:0:0, 0:0:0);
    ( USERCLK => CFGLINKCONTROLASPMCONTROL[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGLINKCONTROLASPMCONTROL[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGLINKCONTROLCOMMONCLOCK) = (0:0:0, 0:0:0);
    ( USERCLK => CFGLINKCONTROLEXTENDEDSYNC) = (0:0:0, 0:0:0);
    ( USERCLK => CFGPCIELINKSTATEN[0]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGPCIELINKSTATEN[1]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGPCIELINKSTATEN[2]) = (0:0:0, 0:0:0);
    ( USERCLK => CFGRDWRDONEN) = (0:0:0, 0:0:0);
    ( USERCLK => CFGTOTURNOFFN) = (0:0:0, 0:0:0);
    ( USERCLK => DBGBADDLLPSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGBADTLPLCRC) = (0:0:0, 0:0:0);
    ( USERCLK => DBGBADTLPSEQNUM) = (0:0:0, 0:0:0);
    ( USERCLK => DBGBADTLPSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGDLPROTOCOLSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGFCPROTOCOLERRSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGMLFRMDLENGTH) = (0:0:0, 0:0:0);
    ( USERCLK => DBGMLFRMDMPS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGMLFRMDTCVC) = (0:0:0, 0:0:0);
    ( USERCLK => DBGMLFRMDTLPSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGMLFRMDUNRECTYPE) = (0:0:0, 0:0:0);
    ( USERCLK => DBGPOISTLPSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGRCVROVERFLOWSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGREGDETECTEDCORRECTABLE) = (0:0:0, 0:0:0);
    ( USERCLK => DBGREGDETECTEDFATAL) = (0:0:0, 0:0:0);
    ( USERCLK => DBGREGDETECTEDNONFATAL) = (0:0:0, 0:0:0);
    ( USERCLK => DBGREGDETECTEDUNSUPPORTED) = (0:0:0, 0:0:0);
    ( USERCLK => DBGRPLYROLLOVERSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGRPLYTIMEOUTSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGURNOBARHIT) = (0:0:0, 0:0:0);
    ( USERCLK => DBGURPOISCFGWR) = (0:0:0, 0:0:0);
    ( USERCLK => DBGURSTATUS) = (0:0:0, 0:0:0);
    ( USERCLK => DBGURUNSUPMSG) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[0]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[10]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[11]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[1]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[2]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[3]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[4]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[5]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[6]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[7]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[8]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXRADDR[9]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXREN) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[0]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[10]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[11]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[1]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[2]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[3]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[4]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[5]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[6]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[7]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[8]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWADDR[9]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[0]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[10]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[11]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[12]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[13]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[14]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[15]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[16]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[17]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[18]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[19]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[1]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[20]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[21]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[22]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[23]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[24]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[25]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[26]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[27]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[28]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[29]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[2]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[30]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[31]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[32]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[33]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[34]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[3]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[4]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[5]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[6]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[7]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[8]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWDATA[9]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMRXWEN) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[0]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[10]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[11]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[1]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[2]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[3]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[4]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[5]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[6]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[7]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[8]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXRADDR[9]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXREN) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[0]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[10]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[11]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[1]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[2]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[3]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[4]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[5]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[6]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[7]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[8]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWADDR[9]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[0]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[10]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[11]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[12]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[13]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[14]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[15]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[16]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[17]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[18]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[19]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[1]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[20]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[21]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[22]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[23]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[24]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[25]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[26]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[27]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[28]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[29]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[2]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[30]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[31]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[32]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[33]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[34]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[35]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[3]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[4]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[5]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[6]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[7]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[8]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWDATA[9]) = (0:0:0, 0:0:0);
    ( USERCLK => MIMTXWEN) = (0:0:0, 0:0:0);
    ( USERCLK => RECEIVEDHOTRESET) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[10]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[11]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[8]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLD[9]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCCPLH[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[10]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[11]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[8]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPD[9]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCNPH[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[10]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[11]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[8]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPD[9]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNFCPH[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNLNKUPN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRBARHITN[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[10]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[11]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[12]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[13]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[14]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[15]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[16]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[17]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[18]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[19]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[20]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[21]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[22]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[23]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[24]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[25]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[26]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[27]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[28]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[29]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[30]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[31]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[6]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[7]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[8]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRD[9]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNREOFN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRERRFWDN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRSOFN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRSRCDSCN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNRSRCRDYN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTBUFAV[0]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTBUFAV[1]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTBUFAV[2]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTBUFAV[3]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTBUFAV[4]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTBUFAV[5]) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTCFGREQN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTDSTRDYN) = (0:0:0, 0:0:0);
    ( USERCLK => TRNTERRDROPN) = (0:0:0, 0:0:0);
    ( USERCLK => USERRSTN) = (0:0:0, 0:0:0);
  endspecify
endmodule // X_PCIE_A1
