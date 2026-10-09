# Ethernet MAC (EMAC) Verification Environment

A SystemVerilog/UVM-based verification project for a three-ingress, three-egress Ethernet MAC (EMAC) design. The environment uses AXI-Stream for packet-data transfers and AXI4-Lite for control-register access. It includes the EMAC RTL, reusable protocol VIPs, a UVM verification environment, a RAL model, and QuestaSim simulation scripts.

> **Project status:** Work in progress. The current sanity test completes with zero UVM errors and zero fatals. Register configuration writes and packet generation have been observed in the simulation log. End-to-end ingress-to-egress packet routing is **not yet verified** because output-side packet checking has not yet been demonstrated.

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

This project develops a verification environment for an EMAC design with three ingress and three egress port paths. The RTL includes a top-level TX-to-RX integration module, a header parser, and an arbiter. The UVM testbench generates packet transactions and configures the DUT through an AXI4-Lite register interface.

### Main goals

- Exercise packet-data paths using AXI-Stream interfaces.
- Configure and access registers through AXI4-Lite.
- Reuse UVM agents, sequences, virtual sequences, and configuration objects.
- Integrate a UVM Register Abstraction Layer (RAL) model using a custom register adapter.
- Debug configuration propagation, packet transfers, and arbitration.
- Add self-checking tests and reproducible evidence before declaring end-to-end behavior verified.

## Architecture

The environment is organized into the following layers:

1. **EMAC RTL**
   - `header_parser.svp` — header parsing and configuration lookup logic.
   - `arbiter.svp` — arbitration logic.
   - `e_mac_tx2_rx_top.sv` — top-level TX-to-RX integration.
2. **Packet-data interfaces**
   - AXI-Stream master/slave interfaces provide packet stimulus and observation paths.
   - Three ingress and three egress paths are intended by the current setup.
3. **Control interface**
   - AXI4-Lite interface and master VIP provide register access.
4. **UVM environment**
   - MAC TX agent and transaction adapter.
   - AXI-Stream VIP components.
   - Virtual sequencer and virtual sequences.
   - RAL register model and custom adapter.
5. **Simulation top**
   - `mac_tb_top.sv` connects the DUT, interfaces, and UVM environment.

Conceptual testbench flow:

```text
                    UVM Test / Virtual Sequence
                              |
                   +----------+-----------+
                   |                      |
             AXI4-Lite Master         MAC TX Agent
                   |                      |
               RAL Model              Transaction
                   |                   Adapter
                   |                      |
                   v                      v
              AXI4-Lite IF            AXI-Stream VIP
                   |                      |
                   +----------+-----------+
                              |
                           EMAC DUT
                    +---------+---------+
                    |                   |
               Header Parser         Arbiter
                    |                   |
                    +---------+---------+
                              |
                    Three ingress/egress paths
```

This diagram represents the intended testbench structure. It does not imply that all data routes have passed end-to-end checking.

## Repository Layout

The following is the expected high-level layout; update names if the repository revision differs.

```text
Ethernet_EMAC/
├── COMMON_LIB1/
│   ├── AXI_LITE_UPDATED_VIP/
│   └── AXI_STREAM_VIP/
└── Ethernet_MAC/
    ├── ENV/
    │   ├── MAC_TX_AGENT/
    │   ├── MAC_RX_AGENT/
    │   ├── MAC_INF/
    │   ├── RAL_REG/
    │   ├── mac_base_vseqs.sv
    │   ├── mac_env.sv
    │   ├── mac_env_pkg.sv
    │   ├── mac_tx2rx_config.sv
    │   └── mac_vseqr.sv
    ├── RTL/
    │   ├── Interface/
    │   ├── arbiter.svp
    │   ├── e_mac_tx2_rx_top.sv
    │   └── header_parser.svp
    ├── SIM/
    │   ├── Makefile
    │   └── wave.do
    ├── TEST/
    │   ├── SEQS/
    │   ├── TESTS/
    │   ├── VSEQS/
    │   ├── mac_base_test.sv
    │   └── mac_test_pkg.sv
    └── TOP/
        └── mac_tb_top.sv
```

`COMMON_LIB1` contains reusable protocol VIP sources used by the EMAC testbench.

## Verification Environment

| Component | Responsibility |
|---|---|
| MAC TX agent | Generates and represents MAC-side transactions. |
| MAC TX sequence item | Holds transaction-level packet stimulus. |
| MAC TX adapter | Converts transaction data into AXI-Stream VIP sequence items. |
| AXI-Stream master/slave VIPs | Provide packet-interface drivers, monitors, and sequencers. |
| AXI4-Lite master VIP | Drives control-register read/write transactions. |
| Virtual sequencer | Coordinates sequences across the environment. |
| Virtual sequences | Coordinate MAC and protocol-level stimulus. |
| RAL register block | Models control registers and fields. |
| RAL adapter | Converts between UVM register operations and AXI4-Lite bus transactions. |
| Test and top modules | Configure tests and connect the DUT to the testbench. |

The current sanity test exercises register configuration and packet generation. The presence of a component in the repository does not, by itself, demonstrate that its intended scenario has passed.

## RAL and Control-Path Verification

The RAL sources are located under `Ethernet_MAC/ENV/RAL_REG/`:

- `mac_ral_reg.sv` — register and field definitions.
- `mac_ral_reg_block.sv` — register block and address-map construction.
- `mac_ral_reg_adapter.sv` — conversion between RAL operations and AXI4-Lite transactions.
- `mac_ral_reg_pkg.sv` — RAL package.
- `ral_base_seqs.sv` — base register-sequence support (included by the test package in the current setup).

Intended access path:

```text
RAL sequence
    -> RAL model
    -> custom uvm_reg_adapter
    -> AXI4-Lite master driver
    -> AXI4-Lite interface
    -> DUT register/configuration logic
```

The current sanity log shows three connection-configuration writes and three output-port register writes. Register-level bus activity should be evaluated separately from packet routing: successful register writes alone do not prove that a packet reaches the expected output.

For exact register names, offsets, reset values, field widths, and access policies, use the current definitions in `mac_ral_reg.sv` and `mac_ral_reg_block.sv` as the source of truth.

## Interfaces and Port Mapping

The intended logical port-ID mapping is:

| Logical ingress | Input `PORT_ID` | Intended output `PORT_ID` |
|---|---:|---:|
| In_Port0 | `3` | `8` |
| In_Port1 | `4` | `9` |
| In_Port2 | `5` | `10` |

This is the mapping configured by the current sanity sequence. Confirm actual signal-to-interface connections in `TOP/mac_tb_top.sv` and `RTL/e_mac_tx2_rx_top.sv` before treating it as a physical pin-level mapping.

The architecture uses a connection-configuration lookup based on `{port_id, VLAN}` and a configuration-memory base address of `0x4000`. The sanity log shows the following observed configuration writes:

| Input `PORT_ID` | Example VLAN | Connection ID | Observed AXI4-Lite address | Output selector value |
|---:|---:|---:|---:|---:|
| `3` | `0x7B2` | `0` | `0x77B2` | `8` |
| `4` | `0x35A` | `1` | `0x835A` | `9` |
| `5` | `0x68A` | `2` | `0x968A` | `10` |

The output-port register writes were observed at offsets `0x3000`, `0x3001`, and `0x3002`, with values `8`, `9`, and `10`, respectively.

### Protocol roles

| Interface/protocol | Role |
|---|---|
| AXI4-Lite | Control and register access, including RAL frontdoor operations. |
| AXI-Stream | Packet-data stimulus and observation paths. |
| UVM RAL | Register-level abstraction and access sequences. |

The current testbench uses a **32-bit AXI-Stream `TDATA` bus** (4 bytes per beat). The logged 64-byte packets are represented as 16 beats of 4 bytes each, with `TKEEP = 4'hF` for the logged beats. Confirm the interface declarations for `TLAST`, `TVALID`, and `TREADY` when documenting the complete protocol configuration.

## Current Verification Status

The status below reflects the current development log and should be updated as more self-checking tests are added.

| Area | Status | Evidence / qualification |
|---|---|---|
| RTL compilation | Successful for the reported build | Compiler warnings remain. |
| Basic sanity simulation | Completed successfully | Test reached `$finish` at 715 ns with zero UVM errors and zero fatals. |
| RAL-to-AXI4-Lite configuration writes | Exercised | Three connection-configuration writes and three output-port register writes were observed. |
| Packet generation | Exercised | Three 64-byte packets were generated, one per configured ingress port. |
| Output-port register programming | Exercised | Values `8`, `9`, and `10` were written to register offsets `0`, `1`, and `2`. |
| Simulator warnings | Open | Nine simulator warnings remain, including associative-array access warnings and AXI-Lite clocking-block warnings. |
| Header parsing and connection lookup | Evidence needed | Add directed tests and observable checks for valid and invalid configuration cases. |
| Arbitration behavior | Evidence needed | Add contention tests and check selection behavior against the RTL's arbitration policy. |
| End-to-end ingress-to-egress routing | **Not yet verified** | Requires observed egress packets and self-checking comparisons against expected destination and packet contents. |
| Functional/code coverage closure | Not established | Do not report coverage closure without EMAC-specific results. |

### Evidence needed before claiming end-to-end routing

For each routing scenario, capture:

- Ingress port and packet fields, including VLAN and relevant header fields.
- Programmed configuration/register values.
- Expected output port and expected packet contents.
- Observed egress transaction from a monitor.
- Scoreboard or explicit comparison result.
- Test name, simulator transcript, and waveform when useful for debugging.

A passing compile or a simulation that reaches `$finish` is not sufficient by itself to claim functional routing correctness.

## Running the Simulation

The project includes a simulation Makefile and waveform setup:

- Makefile: `Ethernet_MAC/SIM/Makefile`
- Waveform setup: `Ethernet_MAC/SIM/wave.do`
- Testbench top: `Ethernet_MAC/TOP/mac_tb_top.sv`

Run from the simulation directory in an environment configured for QuestaSim:

```bash
cd Ethernet_MAC/SIM
make sim
```

The exact targets and required environment variables depend on the current Makefile and local simulator setup. To inspect the commands that a target would execute, use:

```bash
make -n sim
```

The repository may also include standalone simulation collateral for shared VIPs. Such tests validate VIP behavior independently and should not be treated as proof of full EMAC integration.

### Simulation artifacts

Keep generated simulator output out of source control unless it is intentionally included as a small, curated verification artifact. Preserve the relevant transcript/log and, when useful, a waveform or coverage database for reproducibility. Large transient files such as `.wlf`, `.ucdb`, and generated simulator work libraries are usually better handled through `.gitignore` or an external artifact store.

## Known Limitations and Next Steps

1. **Make the sanity test self-checking.** Compare expected and observed transactions instead of relying only on printed driver activity.
2. **Validate RAL access.** Add frontdoor read/write tests and compare readback against expected values.
3. **Verify configuration address formation.** Check VLAN and Port-ID propagation at the RAL adapter, AXI4-Lite driver, and DUT-facing signals.
4. **Verify header parsing.** Add directed tests for supported header cases and malformed or unsupported cases.
5. **Verify connection validity.** Exercise valid and invalid configuration entries and check the specified accept/drop behavior.
6. **Verify arbitration.** Exercise multiple eligible sources and check selection behavior against the implemented policy.
7. **Add end-to-end packet checking.** Compare ingress stimulus with the expected egress packet and output port.
8. **Record regression evidence.** Track test status, failures, simulator version, and coverage by test and revision.
9. **Resolve or document compiler/simulator warnings.** Review the non-standard `foreach` syntax and associative-array access warnings, as well as the AXI-Lite clocking-block warnings.

## Tools and Technologies

- SystemVerilog
- UVM
- UVM Register Abstraction Layer (RAL)
- AXI4-Lite
- AXI-Stream
- QuestaSim
- Make

## Project Status

This is an actively developed verification project. The repository demonstrates the structure of an EMAC RTL/UVM environment and reusable protocol VIP integration. Verification claims will be expanded as directed tests, self-checking results, and reproducible simulation evidence are added.

---

**Maintainer:** Khush Patel
