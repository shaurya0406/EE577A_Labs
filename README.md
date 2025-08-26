# EE577A_Labs

This repository contains my projects and lab work for **EE577A: VLSI System Design Laboratory** at the University of Southern California. It currently includes two major design projects:

* **Comparator Design** – Design, sizing, and characterization of an 8-bit and 16-bit digital comparator using standard cell and custom logic approaches.
* **SRAM\_512bit Project** – Development, simulation, and characterization of a 512-bit SRAM macro, including bitcell, sense amplifier, and peripheral circuitry exploration.

---

## 8/16-bit Comparator Design

* Designed and sized **8-bit and 16-bit comparators** for **minimum worst-case delay**.
* Explored multiple circuit topologies including **pass transistor logic**, **AOI/OAI gates**, and **standard cell-based design**.
* Verified functionality and characterized timing/power using **Cadence Virtuoso, Pegasus, and Spectre simulations**.
* Optimized for robustness across corners with final metrics including propagation delay, input thresholds, and hysteresis values.

---

## SRAM 512-bit Project

* Developed a **512-bit SRAM macro** with **6T bitcell**, wordline/bitline drivers, and sense amplifier integration.
* Extracted **read and write timing constraints** using Cadence Maestro vector files.
* Characterized read stability (RSNM/WSNM), access delays, and energy efficiency.
* Documented trade-offs between **bitcell sizing, stability, and delay** across corners.

---

## Tools & Technologies

* **Cadence Virtuoso, Spectre, Pegasus, Tempus**
* **SPICE/CDL netlists** for transistor-level simulations

---
