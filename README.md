# Ethernet MAC (EMAC) Verification Environment

A SystemVerilog/UVM-based verification project for a three-port Ethernet MAC (EMAC), with AXI-Stream packet interfaces and an AXI4-Lite control path. The repository includes the EMAC RTL, reusable protocol VIPs, a UVM verification environment, and simulation scripts for development and debugging.

> **Project status:** Work in progress. RTL compilation and a basic simulation run have been reported during development. Full end-to-end packet routing is **not yet claimed as verified**; that requires explicit source-to-destination checking and recorded test evidence.

## Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Repository Layout](#repository-layout)
- [Verification Environment](#verification-environment)
- [RAL and Control-Path Verification](#ral-and-control-path-verification)
- [Interfaces and Port Mapping](#interfaces-and-port-mapping)
- [Current Verification Status](#current-verification-status)
- [Running the Simulation](#running-the-simulation)
- [Known Limitations and Next Steps](#known-limitations-and-next-steps)
- [Tools and Technologies](#tools-and-technologies)

## Overview

The project targets verification of an EMAC design with three packet-facing port paths. The design sources include a top-level TX-to-RX integration module, a header parser, and an arbiter. The UVM testbench provides layered components and reusable AXI protocol VIPs to exercise packet-side traffic and control-register access.

### Main goals

- Exercise packet-side behavior using AXI-Stream interfaces.
- Configure and access control/status registers through AXI4-Lite.
- Use reusable UVM agents, sequences, virtual sequences, and configuration objects.
- Integrate a UVM Register Abstraction Layer (RAL) model through a custom register adapter.
- Debug transaction and configuration propagation through the testbench and DUT.
- Build evidence incrementally before marking integrated routing scenarios as verified.

## Architecture

At a high level, the environment is organized into these layers:

1. **EMAC RTL**
   - `header_parser.svp` — header parsing and configuration lookup logic.
   - `arbiter.svp` — arbitration logic.
   - `e_mac_tx2_rx_top.sv` — top-level TX-to-RX integration.
2. **Packet-data interfaces**
   - AXI-Stream master/slave interfaces connect packet stimulus and observation paths.
   - Three interface sets are instantiated/configured for the three-port setup.
3. **Control interface**
   - AXI4-Lite interface and master VIP provide the control/register access path.
4. **UVM environment**
   - MAC TX agent and transaction adapter.
   - AXI-Stream VIP components.
   - UVM virtual sequencer and virtual sequences for coordinating stimulus.
   - RAL register model and custom adapter.
5. **Simulation top**
   - `mac_tb_top.sv` connects the DUT, interfaces, and UVM testbench.

Conceptual flow:

```text
                    UVM Test / Virtual Sequence
                              |
                  +-----------+-----------+
                  |                       |
            AXI4-Lite Master        MAC TX Agent
                  |                       |
            Control / RAL             Transaction
                  |                    Adapter
                  |                       |
                  v                       v
             AXI4-Lite IF          AXI-Stream VIPs
                  |                (master/slave sets)
                  |                       |
                  +----------+------------+
                             |
                       EMAC DUT Top
                   +---------+---------+
                   |                   |
              Header Parser         Arbiter
                   |                   |
                   +---------+---------+
                             |
                  Three-port TX/RX paths
```

This diagram is a conceptual view of the implemented testbench structure, not evidence that every datapath route has passed end-to-end checking.

## Repository Layout

```text
Ethernet_EMAC/
├── COMMON_LIB1/
│   ├── AXI_LITE_MASTER_VIP/
│   ├── AXI_LITE_UPDATED_VIP/
│   └── AXI_STREAM_VIP/
├── Ethernet_MAC/
│   ├── ENV/
│   │   ├── MAC_TX_AGENT/
│   │   ├── RAL_REG/
│   │   ├── mac_base_vseqs.sv
│   │   ├── mac_env.sv
│   │   ├── mac_env_pkg.sv
│   │   ├── mac_tx2rx_config.sv
│   │   └── mac_vseqr.sv
│   ├── RTL/
│   │   ├── Interface/
│   │   ├── arbiter.svp
│   │   ├── e_mac_tx2_rx_top.sv
│   │   └── header_parser.svp
│   ├── SIM/
│   │   ├── Makefile
│   │   └── wave.do
│   ├── TEST/
│   │   ├── SEQS/
│   │   ├── TESTS/
│   │   ├── VSEQS/
│   │   ├── mac_base_test.sv
│   │   └── mac_test_pkg.sv
│   └── TOP/
│       └── mac_tb_top.sv
└── README.md
```

`COMMON_LIB1` contains reusable protocol VIP sources shared by the EMAC environment. Exact file availability can vary by repository revision.

## Verification Environment

The EMAC UVM environment includes the following components:

| Component | Responsibility |
|---|---|
| MAC TX agent | Generates and represents MAC-side transactions. |
| MAC TX sequence item | Holds transaction-level stimulus data. |
| MAC TX adapter | Adapts transaction data for the packet-side interface flow. |
| AXI-Stream master/slave VIPs | Provide reusable packet-interface drivers, monitors, sequencers, and configuration. |
| AXI4-Lite master VIP | Drives control-register read/write transactions. |
| Virtual sequencer | Coordinates sequences across the environment. |
| Virtual sequences | Coordinate MAC and protocol-level stimulus. |
| RAL register block | Represents modeled control registers and fields. |
| RAL adapter | Converts between UVM register operations and AXI4-Lite bus transactions. |
| Test/top modules | Configure and start tests and connect the DUT and interfaces. |

The current test sources include a MAC sanity sequence/test and virtual-sequence infrastructure. The existence of a component or sequence in the repository does not by itself establish that its intended scenario has passed.

## RAL and Control-Path Verification

The project contains a UVM RAL implementation under `Ethernet_MAC/ENV/RAL_REG/`:

- `mac_ral_reg.sv` — register/field definitions.
- `mac_ral_reg_block.sv` — register block and map construction.
- `mac_ral_reg_adapter.sv` — conversion between RAL operations and AXI4-Lite transactions.
- `mac_ral_reg_pkg.sv` — RAL package.
- `ral_base_seqs.sv` — base register sequences.

The intended access path is:

```text
RAL sequence
    -> RAL model
    -> custom uvm_reg_adapter
    -> AXI4-Lite master driver
    -> AXI4-Lite interface
    -> DUT control/register logic
```

An important debug focus has been propagation of VLAN and Port-ID-related address/configuration values through this path. Register-level access and correct configuration propagation should be evaluated separately from packet routing: successful register bus activity alone does not prove that a configured packet reaches the expected output port.

**Register-map note:** Use the implemented definitions in `mac_ral_reg.sv` and `mac_ral_reg_block.sv` as the source of truth for exact register names, offsets, reset values, access policies, and field widths. Those details should not be inferred solely from architectural notes.

## Interfaces and Port Mapping

The design is organized around three ingress/egress port paths and AXI-Stream data interfaces, with AXI4-Lite used for control access.

Architectural notes describe ingress port identifiers as follows:

| Logical ingress | Port ID in architecture notes |
|---|---:|
| Port 0 | `3` |
| Port 1 | `4` |
| Port 2 | `5` |

These values describe the documented logical Port-ID convention; they should not be confused with HDL interface instance names or physical pin names. Confirm actual signal-to-interface connections in `Ethernet_MAC/TOP/mac_tb_top.sv` and `Ethernet_MAC/RTL/e_mac_tx2_rx_top.sv` before relying on a pin-level mapping.

The architecture notes also describe a connection-configuration lookup based on `{port_id, VLAN}` and a configuration-memory base address of `0x4000`. The notes describe a connection-valid bit and a Connection ID used by downstream selection/arbitration logic. Treat these as architectural intent until each behavior is traced to the current RTL and covered by a passing test.

### Protocol roles

| Interface/protocol | Role in this project |
|---|---|
| AXI4-Lite | Control and register access, including RAL frontdoor operations. |
| AXI-Stream | Packet-data transfer stimulus/observation paths. |
| UVM RAL | Register-level abstraction and access sequences. |

The current architecture notes refer to AXI-Stream `TDATA` as 32 bytes wide. Verify the exact HDL width and associated `TKEEP`/`TSTRB`/`TLAST`/`TVALID`/`TREADY` semantics directly against the interface declarations in the current revision before using this as a fixed interface specification.

## Current Verification Status

Status is intentionally conservative and based on the development evidence currently available.

| Area | Status | Evidence / qualification |
|---|---|---|
| Repository structure and testbench components | Implemented | EMAC RTL, UVM environment, RAL files, tests, top, and simulation scripts are present. |
| RTL compilation | Reported successful during development | A compile run was reported; `header_parser.svp` emitted a warning about non-standard `foreach` loop-variable-list syntax. |
| Basic simulation | Reported run during development | A basic simulation run was reported. Keep the corresponding transcript/log and waveform with the revision to make this independently reproducible. |
| AXI-Stream reusable VIP | Present | Master/slave UVC source files and standalone simulation collateral are present. |
| AXI4-Lite reusable VIP | Present | Master VIP source files and standalone simulation collateral are present. |
| RAL model and custom adapter | Implemented in source | End-to-end register read/write correctness should be recorded with explicit pass/fail results. |
| VLAN / Port-ID configuration propagation | Under debug | Previously identified as an area needing careful checking through RAL → adapter → driver → DUT. |
| Header parsing and connection lookup | RTL present; coverage evidence needed | Require directed tests and observable checks for valid/invalid configuration cases. |
| Arbitration behavior | RTL present; coverage evidence needed | Require contention and grant/selection checks. |
| End-to-end ingress-to-egress routing | **Not yet claimed as verified** | Requires source-to-destination packet checking, expected-port assertions/scoreboard results, and saved passing logs. |
| Functional/code coverage closure | Not established for EMAC | Do not reuse coverage numbers from unrelated APB projects as EMAC results. |

### Evidence needed before claiming end-to-end routing

For each routing scenario, capture at minimum:

- Ingress port and packet fields, including VLAN and relevant header fields.
- The programmed configuration/register values used for the test.
- Expected output port and expected packet contents.
- Observed egress transaction from the monitor.
- Scoreboard or explicit comparison result.
- Test name, simulator transcript, and waveform when debugging is required.

A passing compile or a simulation that reaches `$finish` is not sufficient by itself to claim functional routing correctness.

## Running the Simulation

The project includes a simulation Makefile and waveform setup:

- Makefile: `Ethernet_MAC/SIM/Makefile`
- Waveform setup: `Ethernet_MAC/SIM/wave.do`
- Testbench top: `Ethernet_MAC/TOP/mac_tb_top.sv`

Run commands from the environment configured for your QuestaSim installation. For example:

```bash
cd Ethernet_MAC/SIM
make
```

The exact targets and required environment variables depend on the current Makefile and local simulator setup. Inspect the available targets before running a specific test:

```bash
make -n
```

If the Makefile defines separate compile and run targets, use those target names as defined in the file. The repository also includes standalone simulation scripts under the shared VIP directories; those validate the VIP setup independently and should not be treated as proof of full EMAC integration.

### Suggested run-artifact handling

Keep generated simulator output out of source control unless it is intentionally being used as a small, curated verification artifact. Preserve the relevant transcript/log and, when useful, a waveform or coverage database for reproducibility. Large transient files such as `.wlf`, `.ucdb`, and generated simulator work libraries are usually better handled through `.gitignore` or an external artifact store.

## Known Limitations and Next Steps

1. **Make the sanity test self-checking.** Add or confirm expected transaction comparisons instead of relying only on printed driver/monitor activity.
2. **Validate RAL access.** Run register frontdoor read/write tests and compare readback against expected values.
3. **Verify configuration address formation.** Check VLAN and Port-ID propagation at the RAL adapter, AXI4-Lite driver, and DUT-facing signals.
4. **Verify header parsing.** Add directed tests for supported header cases and malformed or unsupported cases.
5. **Verify connection validity.** Exercise valid and invalid configuration entries and check the specified accept/drop behavior.
6. **Verify arbitration.** Exercise multiple eligible sources and check the selected source/destination behavior against the implemented arbitration policy.
7. **Add end-to-end packet checking.** Compare ingress stimulus with the expected egress packet and expected output port.
8. **Record regression evidence.** Track test status, failures, simulator version, and coverage results by test and revision.
9. **Resolve or document compiler warnings.** In particular, review the non-standard `foreach` syntax warning in `header_parser.svp`.

## Tools and Technologies

- SystemVerilog
- UVM
- UVM Register Abstraction Layer (RAL)
- AXI4-Lite
- AXI-Stream
- QuestaSim
- Make

## Project Status

This is an actively developed verification project. The repository demonstrates the structure of an EMAC RTL/UVM setup and reusable protocol VIP integration. Verification claims will be expanded only as directed tests, self-checking results, and reproducible simulation evidence are added.

---

*Maintainer: Khush Patel*
