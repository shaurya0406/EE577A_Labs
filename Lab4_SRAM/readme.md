# Final Report for 512-bit SRAM Array Design  
**Course:** EE 577A – Spring 2025  
**Lab:** 4 – SRAM ARRAY DESIGN  
**Name:** Shaurya Chandra

---

## 1. Introduction

In this lab, we designed and verified a 512‑bit SRAM array that employs four banks (each 8×16) with interleaved 16‑bit word storage. The design extends a provided 6‑T SRAM cell by optimizing transistor sizing for enhanced stability and performance. The peripheral circuitry – comprising the row decoder, precharge network, sense amplifier (SA), column multiplexers, and output registers – was designed and simulated to validate functionality and meet timing requirements. This report documents the detailed design specifications, simulation results, and critical timing analyses.

---

## 2. Design Overview and Schematics

### 2.1. SRAM Cell and Peripheral Circuitry
- **SRAM Cell:**  
  The base 6‑T cell was simulated and optimized. Initially, the read SNM (RSNM) measured 199.505 mV, but upsizing the NMOS from 480 nm to 500 nm improved RSNM to 210.025 mV.  
- **Sense Amplifier:**  
  To accurately sense a small differential (e.g., BL dropping from 1 V to 0.9 V during a read '0'), the bottom NMOS devices in the SA were sized up to 650 nm. Measured latching delays were 138 ps for reading '0' and 164 ps for reading '1'.
- **Precharge and Decoder:**  
  Bit lines are precharged to 1 V. The decoder, with a delay of 27.87 ps, rapidly activates the corresponding word line. For the write operation, once the WL is active, a cell update delay of 82.39 ps is observed, resulting in a total write delay of about 110.26 ps.
- **Additional Peripherals:**  
  The design incorporates word line (WL) and bit line (BL) capacitance approximations. Using extracted capacitances (\( c_{dd} = 36.3374 \) aF and \( c_{gg} = 85.6103 \) aF), the lumped BL and WL loads were estimated as approximately 4.58 fF and 0.60 fF respectively.

### 2.2. Block-Level Schematics
- **SRAM 1-bit Schematic:**  
![SRAM_1bit_Sch](images/SRAM_1bit_Sch.png)
- **SRAM 16-bit Row Schematic:**  
![SRAM_16bit_Row_Sch](images/SRAM_16bit_Row_Sch.png)
- **SRAM Bank Schematic (8x16):**  
![SRAM_Bank_Sch](images/SRAM_Bank_Sch.png)
- **Pre-Charge Schematic (1-bit):**  
![PreCharge_Sch](images/PreCharge_Sch.png)
- **Column MUX Schematic (1-bit):**  
![ColumnMux_1bit_Sch](images/ColumnMux_1bit_Sch.png)
- **Column MUX Schematic (4to1):**  
![ColumnMux_4to1_Sch](images/ColumnMux_4to1_Sch.png)
- **Column MUX Schematic (16-bit for 1 Bank):**  
![ColumnMux_16bit_Sch](images/ColumnMux_16bit_Sch.png)
- **Column Decoder (2to4) using A1, A0:**  
![ColumnDecoder(2to4)_Sch](images/ColumnDecoder(2to4)_Sch.png)
- **Row Decoder (3to8) using A4, A3, A2:**  
![RowDecoder(3to8)_Sch](images/RowDecoder(3to8)_Sch.png)
- **SenseAmp Schematic (1-bit)**  
![SenseAmp_1bit_Sch](images/SenseAmp_1bit_Sch.png)
- **NAND Latch for SenseAmp (1-bit)**  
![NAND_Latch_Sch](images/NAND_Latch_Sch.png)
- **SenseAmpLatch Schematic (1-bit)**  
![SenseAmpLatch_1bit_Read0_Sch](images/SenseAmpLatch_1bit_Read0_Sch.png)
- **Write Driver Schematic (1-bit)**  
![WriteDriver_1bit_Sch](images/WriteDriver_1bit_Sch.png)
- **Top-Level Schematic for 512-bit**  
![SRAM_512_TB_Sch](images/SRAM_512_TB_Sch.png)

**Bank TB Schematic (8×16):**  
  Each bank consists of 8 rows and 16 columns. The bank-level schematic shows precharge circuits, the word line decoder, and the interconnection to the peripheral sense amplifier circuitry.
- **Top-Level Integration:**  
  The overall 512‑bit SRAM integrates four such banks, with interleaved data storage across banks. A column multiplexer (MUX) and output registers are used to reassemble the 16‑bit words. Figures in the submitted file set provide detailed layouts of the bank schematic as well as the 512‑bit top-level schematic.


## 3. SNM Characterization

### 3.1. Read SNM (RSNM)
- **Initial RSNM:** 199.505 mV (slightly below requirement)
- **After Upsizing NMOS (480 nm → 500 nm):** RSNM improved to 210.025 mV  
- **Testing Setup:**  
  The RSNM butterfly curves, as obtained through Maestro setup and simulation graphs, clearly illustrate the improvement.
- **RSNM Schematic**  
![RSNM_Sch](images/RSNM_Sch.png)
- **RSNM Maestro**  
![RSNM_Maestro](images/RSNM_Maestro.png)
- **RSNM Butterfly Graph**  
![RSNM_Graph](images/RSNM_Graph.png)

#### After Upsizing
- **RSNM Schematic**  
![RSNM_Sch_Sized](images/RSNM_Sch_Sized.png)
- **RSNM Butterfly Graph**  
![RSNM_Graph_Sized](images/RSNM_Graph_Sized.png)

### 3.2. Write SNM (WSNM)
- **Measured WSNM:** 444.19 mV  
- **Interpretation:**  
  This value comfortably exceeds the lab requirement of 395 mV, confirming robust write operation performance. 
- **WSNM Schematic**  
![WSNM_Sch](images/WSNM_Sch.png)
- **WSNM Maestro**  
![WSNM_Maestro](images/WSNM_Maestro.png)
- **WSNM Graph**  
![WSNM_Graph](images/WSNM_Graph.png)

---

## 4. Timing Analysis

### 1-Bit SRAM Testbench Schematic
![SRAM_1bit_Sch](images/SRAM_1bit_Sch.png)
### 1-Bit SRAM Maestro
![SRAM_1bit_TB_Maestro](images/SRAM_1bit_TB_Maestro.png)
#### Write Operation (Write '1' when stored value is 0)
- **Precharge Time:** 428.7 ps  
- **Decoder Delay:** 27.87 ps  
- **WL-to-Q Delay:** 82.39 ps  
- **Total Write Delay:**  
  27.87ps + 82.39ps = 110.17ps

#### Read Operation (Read '1')
- **Bitline Delay (read_en active to BL ≈ 0.9 V):** 61.16 ps  
- **Sense Amplifier Delay (sense_en active to data output transition):** 85.37 ps  
- **Total Read Delay:**  
  61.16ps + 85.37ps = 146.53ps
  
- **Data Output Latching:**  
  Data is captured by the output register at the next clock edge.

*Waveform captures from the 1-bit testbench validate these timing measures. Detailed screenshots show the transitions along the bit lines, word lines, and SA outputs.*

---

### 4.1. Write 1 Operation

**Objective:** Store a logic high ('1') in the cell when its initial state is '0'.

**Waveform Behavior:**
- **Precharge Phase:**  
  The bit lines (BL and BLB) are precharged to 1 V to prepare the memory cell for a new write operation.
- **Activation of the Word Line:**  
  The decoder activates the word line (WL) with a short delay (≈27.87 ps) after precharge. This enables the access transistors.
- **Data Driving:**  
  The write driver forces the appropriate voltage on the selected bit line. In a Write 1 operation, the driver ensures that the cell node is driven to by driving BLB and hence QB node to 0. As the word line is asserted, the differential voltage applied at the cell causes the cell to flip its internal state from 0 to 1.
- **Propagation Delay:**  
  The waveform shows that, after WL activation, there is a delay (~82.39 ps) for the internal node (denoted Q) to switch to the new state. The total write delay (decoder delay plus the WL-to-Q flipping delay) is approximately 110.26 ps.

![SRAM_1bit_TB_Write1_Sch](images/SRAM_1bit_TB_Write1_Sch.png)
![SRAM_1bit_TB_Write1_Graph](images/SRAM_1bit_TB_Write1_Graph.png)
---

### 4.2. Read 1 Operation

**Objective:** Verify that the cell correctly holds the logic high ('1') after a Write 1 operation.

**Waveform Behavior:**
- **Precharge and Initiation:**  
  Before the read operation, the bit lines are again precharged to 1 V.
- **Bit Line Discharge:**  
  Upon asserting the read enable signal, the cell begins to influence the bit line. For a stored '1', the cell weakly pulls the BL from 1 V down to around 0.9 V. The waveform shows this small voltage drop occurring over about 61.16 ps.
- **Sense Amplifier Activation:**  
  The sense amplifier is enabled (sense_en signal), and it senses and latches the data. The transition at the SA output is observed after ~85.37 ps, amplifying the small differential observed on the bit line.
- **Output Capture:**  
  The latched output then goes to the output register at the subsequent clock edge.

![SRAM_1bit_TB_Read1_Vec_Graph](images/SRAM_1bit_TB_Read1_Vec_Graph.png)

---

### 4.3. Write 0 Operation

**Objective:** Change the cell’s stored value from '1' to '0'.

**Waveform Behavior:**
- **Preparation and Precharge:**  
  As before, precharge brings the bit lines to 1 V.
- **Word Line Activation and Data Driving:**  
  The decoder activates the appropriate word line. This time, the write driver forces the cell node to transition from a ‘1’ to a ‘0’. The corresponding bit line also reflects this forced low value.
- **Switching Delay:**  
  Similar to the Write 1 operation, there is a delay (around 82.39 ps after WL activation) until the cell internal node (Q) changes its state to '0'. The total delay again sums up to approximately 110.26 ps.

![SRAM_1bit_TB_Write0_Graph](images/SRAM_1bit_TB_Write0_Graph.png)
---

### 4.4. Read 0 Operation

**Objective:** Verify that the cell correctly holds a logic low ('0') after a Write 0 operation.

**Waveform Behavior:**
- **Precharge Phase:**  
  Bit lines are precharged to 1 V once again.
- **Bit Line Behavior on Read:**  
  For a cell storing '0', the cell influences the bit line such that it remains near the high voltage or is pulled even higher on the complementary line (depending on the design). The waveform shows a differential change where the bit line does not drop as much as in a Read 1 case, or it might demonstrate a slight voltage difference that the sense amplifier detects.
- **Sense Amplifier Latching:**  
  With the sense amplifier enabled, the SA detects this differential (which now represents a logic '0') and rapidly latches the correct output, again within about 85.37 ps.
- **Final Output:**  
  The output is then latched at the next clock edge.
---

### 4.5. Final Write 1 Operation

**Objective:** Restore the cell’s stored value to '1' after a read 0 operation.

**Waveform Behavior:**
- **Precharge and Activation:**  
  The final operation begins with another precharge phase followed by word line activation.
- **Data Driving:**  
  This time, the write driver forces the cell node to return from 0 to 1. The waveform exhibits a clear rising edge as the cell is rewritten with a logic high value.
- **Switching and Stabilization:**  
  The internal node transitions again within the write delay of approximately 110.26 ps, confirming a successful Write 1 operation that restores the initial state.

Based on these waveforms, we decide the control signals timing.

---

### 4.2. Bank-Level (8×16) Testbench
- The bank-level simulation waveforms confirm proper sequencing of address signals, control signals (read_en, write_en, sense_en, precharge_en), and valid data propagation through the SRAM cells.
- Data written and read back match the expected values, demonstrating correct operation across all 16 bits.

Clk period is 2n defined in maestro file

![SRAM_Bank1_TB_Sch](images/SRAM_Bank1_TB_Sch.png)

![SRAM_Bank1_TB_Graph](images/SRAM_Bank1_TB_Graph.png)

```
; Cadence Virtuoso Vector File for SRAM Bank 1

radix 1 41 41 1 1 1 1 1 4 4
io    i ii ii  i  i  i  i  i  i
vname precharge_en A<[4:0]> A_bar<[4:0]> write_en decoder_en pre_en_SA read_en sense_en data<[3:0]> data_bar<[3:0]>
tunit ns
slope 0.01
vih 1.0
vil 0.0

; write - 0101 at 00 operation
0    1 00 F1 0 0 1 1 0 5 A    ; Initial Condition, Everything is disabled
2    0 00 F1 0 0 1 1 0 5 A    ; Precharge
3    1 00 F1 1 0 1 1 0 5 A    ; Precharge_deactivated, write_en is activated and pr_en is deactivated 
4    1 00 F1 1 1 1 1 0 5 A    ; DECODER_EN is activated (made zero because decoder is low active)
6    0 00 F1 0 0 1 1 0 5 A    ; End of write operation and precharge restarts

; read - 0101 at 00 operation 
7    1 00 F1 0 0 1 1 0 5 A    ; Initial Condition, Everything is disabled
8    0 00 F1 0 0 0 1 0 5 A    ; Precharge and SA Precharge activated
9    1 00 F1 0 1 1 0 0 5 A    ; Read phase starts, DECODER_EN and read_en are activated, SA_precharge_en is deactivated 
9.1  0 00 F1 0 0 0 1 1 5 A    ; Sense_en is activated, decoder and read_en are deactivated
9.2  0 00 F1 0 0 1 1 0 5 A    ; Precharge 

; write - 1010 at 01 operation
12   0 01 F0 0 0 1 1 0 A 5    ; Precharge
13   1 01 F0 1 0 1 1 0 A 5    ; Precharge_deactivated, write_en is activated and pr_en is deactivated 
14   1 01 F0 1 1 1 1 0 A 5    ; DECODER_EN is activated (made zero because decoder is low active)
16   0 01 F0 0 0 1 1 0 A 5    ; End of write operation and precharge restarts

; read - 1010 at 00 operation 
17   1 00 F1 0 0 1 1 0 A 5    ; Initial Condition, Everything is disabled
18   0 00 F1 0 0 0 1 0 A 5    ; Precharge and SA Precharge activated
19   1 00 F1 0 1 1 0 0 A 5    ; Read phase starts, DECODER_EN and read_en are activated, SA_precharge_en is deactivated 
19.1 0 00 F1 0 0 0 1 1 A 5    ; Sense_en is activated, decoder and read_en are deactivated
19.2 0 00 F1 0 0 1 1 0 A 5    ; Precharge 

; read - 1010 at 01 operation 
21   1 01 F0 0 0 1 1 0 A 5    ; Initial Condition, Everything is disabled
22   0 01 F0 0 0 0 1 0 A 5    ; Precharge and SA Precharge activated
23   1 01 F0 0 1 1 0 0 A 5    ; Read phase starts, DECODER_EN and read_en are activated, SA_precharge_en is deactivated 
24   0 01 F0 0 0 0 1 1 A 5    ; Sense_en is activated, decoder and read_en are deactivated
24.1 0 01 F0 0 0 0 1 1 A 5    ; Sense_en is activated, decoder and read_en are deactivated
24.2 0 01 F0 0 0 1 1 0 A 5    ; Precharge 

; write - D at 11 operation
25   1 11 E1 0 0 1 1 0 D 2    ; Initial Condition, Everything is disabled
26   0 11 E1 0 0 1 1 0 D 2    ; Precharge
27   1 11 E1 1 0 1 1 0 D 2    ; Precharge_deactivated, write_en is activated and pr_en is deactivated 
28   1 11 E1 1 1 1 1 0 D 2    ; DECODER_EN is activated (made zero because decoder is low active)
29   0 11 E1 0 0 1 1 0 D 2    ; End of write operation and precharge restarts

; read - D at 11 operation 
30   1 11 E1 0 0 1 1 0 D 2    ; Initial Condition, Everything is disabled
31   0 11 E1 0 0 0 1 0 D 2    ; Precharge and SA Precharge activated
32   1 11 E1 0 1 1 0 0 D 2    ; Read phase starts, DECODER_EN and read_en are activated, SA_precharge_en is deactivated 
33   0 11 E1 0 0 0 1 1 D 2    ; Sense_en is activated, decoder and read_en are deactivated
33.1 0 11 E1 0 0 0 1 1 D 2    ; Sense_en is activated, decoder and read_en are deactivated
33.2 0 11 E1 0 0 1 1 0 D 2    ; Precharge 
```
---



### 4.3. Final 512-bit SRAM Testbench
- **Integration:**  
  The full 512-bit SRAM testbench uses a vector file (SRAM_512_Test.vec) that drives the complete array.
- **Overall Waveforms:**  
  Waveforms exhibit correct precharge, decoding, bitline discharge, sense amplification, and data latching across the four banks.
- **Timing Budget:**  
  Although the individual delays (write ~110.26 ps and read ~146.53 ps) are measured per cell, the integrated design maintains proper timing coordination through additional decoder and MUX delays, ensuring robust performance in the full array. 
  The control signals and their timing is mentioned in the following vector file:

### Clk period is 1n defined in maestro file
### Read and Write take 2 clk cycles of 1ns


![SRAM_1bit_TB_Write1_Sch](images/SRAM_512_TB_Sch.png)
![SRAM_512_TB_Graph](images/SRAM_512_TB_Graph.png)

### Timing Summary Table

| Parameter                                | Value     | Description                                                                         |
|------------------------------------------|-----------|-------------------------------------------------------------------------------------|
| **Clock Period**                         | 1 ns      | Clock period as defined in the vector file.                                         |
| **Write Operation Delays**               |           |                                                                                     |
| Precharge Time                           | 428.7 ps  | Time for bit lines to precharge (reach approximately 0.95 V) before write operations.|
| Decoder Delay                            | 27.87 ps  | Delay from word-line enable (WL activation) until the decoder output activates.     |
| WL-to-Q Flip Delay                       | 82.39 ps  | Delay from WL activation to the cell’s storage node (Q) switching state.             |
| **Total Write Delay**                    | 110.26 ps | Sum of Decoder Delay and WL-to-Q Flip Delay.                                        |
| **Read Operation Delays**                |           |                                                                                     |
| Bitline Discharge Delay                  | 61.16 ps  | Delay from read_en activation to when the bit line falls to 0.9 V.                   |
| Sense Amplifier Delay                    | 85.37 ps  | Delay from sense_en activation to the SA output latching the sensed value.           |
| **Total Read Delay**                     | 146.53 ps | Sum of Bitline Discharge Delay and Sense Amplifier Delay.                           |

---

```
  ; // New Vector File with 16-bit Data Buses (Radix 4444 for data)

radix 1 41 41 1 1 1 1 1 4444 4444
io    i ii ii i i i i i iiii iiii
vname precharge_en A<[4:0]> A_bar<[4:0]> write_en decoder_en pre_en_SA read_en sense_en data<[15:0]> data_bar<[15:0]>
tunit ns
slope 0.01
vih 1.0
vil 0.0

; //=====================================================================
; // WRITE OPERATIONS (Order: 5, 6, 7, 8, 9, 0, 1, 2, 3, 4)
; //=====================================================================

;--- Sequence 5: A = F1, A_bar = 00, Data = 5F2B, data_bar = A0D4 ---
0    1 F1 00 0 0 1 1 0 5F2B A0D4    ; Seq 5 Write: Initial Condition, Everything disabled
2    0 F1 00 0 0 1 1 0 5F2B A0D4    ; Seq 5 Write: Precharge and Present Address & Data
3    1 F1 00 1 0 1 1 0 5F2B A0D4    ; Seq 5 Write: Write Enable activated (precharge deactivated)
4    1 F1 00 1 1 1 1 0 5F2B A0D4    ; Seq 5 Write: DECODER_EN activated

;--- Sequence 6: A = A0, A_bar = 51, Data = 9054, data_bar = 6FAB ---
5    0 A0 51 0 0 1 1 0 9054 6FAB    ; Seq 6 Write: Precharge and Present Address & Data
6    1 A0 51 1 0 1 1 0 9054 6FAB    ; Seq 6 Write: Write Enable activated
7    1 A0 51 1 1 1 1 0 9054 6FAB    ; Seq 6 Write: DECODER_EN activated

;--- Sequence 7: A = 31, A_bar = C0, Data = FF83, data_bar = 007C ---
8    0 31 C0 0 0 1 1 0 FF83 007C    ; Seq 7 Write: Precharge and Present Address & Data
9    1 31 C0 1 0 1 1 0 FF83 007C    ; Seq 7 Write: Write Enable activated
10   1 31 C0 1 1 1 1 0 FF83 007C    ; Seq 7 Write: DECODER_EN activated

;--- Sequence 8: A = 81, A_bar = 70, Data = 19D7, data_bar = E628 ---
11   0 81 70 0 0 1 1 0 19D7 E628    ; Seq 8 Write: Precharge and Present Address & Data
12   1 81 70 1 0 1 1 0 19D7 E628    ; Seq 8 Write: Write Enable activated
13   1 81 70 1 1 1 1 0 19D7 E628    ; Seq 8 Write: DECODER_EN activated

;--- Sequence 9: A = D1, A_bar = 20, Data = 1A2B, data_bar = E5D4 ---
14   0 D1 20 0 0 1 1 0 1A2B E5D4    ; Seq 9 Write: Precharge and Present Address & Data
15   1 D1 20 1 0 1 1 0 1A2B E5D4    ; Seq 9 Write: Write Enable activated
16   1 D1 20 1 1 1 1 0 1A2B E5D4    ; Seq 9 Write: DECODER_EN activated

;--- Sequence 0: A = 51, A_bar = A0, Data = 143B, data_bar = EBC4 ---
17   0 51 A0 0 0 1 1 0 143B EBC4    ; Seq 0 Write: Precharge and Present Address & Data
18   1 51 A0 1 0 1 1 0 143B EBC4    ; Seq 0 Write: Write Enable activated
19   1 51 A0 1 1 1 1 0 143B EBC4    ; Seq 0 Write: DECODER_EN activated

;--- Sequence 1: A = 50, A_bar = A1, Data = 984C, data_bar = 67B3 ---
20   0 50 A1 0 0 1 1 0 984C 67B3    ; Seq 1 Write: Precharge and Present Address & Data
21   1 50 A1 1 0 1 1 0 984C 67B3    ; Seq 1 Write: Write Enable activated
22   1 50 A1 1 1 1 1 0 984C 67B3    ; Seq 1 Write: DECODER_EN activated

;--- Sequence 2: A = B0, A_bar = 41, Data = 211B, data_bar = DEE4 ---
23   0 B0 41 0 0 1 1 0 211B DEE4    ; Seq 2 Write: Precharge and Present Address & Data
24   1 B0 41 1 0 1 1 0 211B DEE4    ; Seq 2 Write: Write Enable activated
25   1 B0 41 1 1 1 1 0 211B DEE4    ; Seq 2 Write: DECODER_EN activated

;--- Sequence 3: A = 50, A_bar = A1, Data = 4C36, data_bar = B3C9 ---
26   0 50 A1 0 0 1 1 0 4C36 B3C9    ; Seq 3 Write: Precharge and Present Address & Data
27   1 50 A1 1 0 1 1 0 4C36 B3C9    ; Seq 3 Write: Write Enable activated
28   1 50 A1 1 1 1 1 0 4C36 B3C9    ; Seq 3 Write: DECODER_EN activated

;--- Sequence 4: A = 91, A_bar = 60, Data = E15C, data_bar = 1EA3 ---
29  0 91 60 0 0 1 1 0 E15C 1EA3    ; Seq 4 Write: Precharge and Present Address & Data
30  1 91 60 1 0 1 1 0 E15C 1EA3    ; Seq 4 Write: Write Enable activated
31  1 91 60 1 1 1 1 0 E15C 1EA3    ; Seq 4 Write: DECODER_EN activated

; //=====================================================================
; // READ OPERATIONS (Faster READ, Order: 5, 3, 2, 7, 9, 3, 4, 1, 8, 5)
; //=====================================================================

;--- Read Block for Sequence 5 (A = F1, A_bar = 00, Data = 5F2B, data_bar = A0D4) ---
32    0 F1 00 0 0 0 1 0 5F2B A0D4    ; Seq 5 Read: Precharge & SA Precharge activated
33    1 F1 00 0 1 1 0 0 5F2B A0D4    ; Seq 5 Read: Read phase starts
33.5  0 F1 00 0 0 0 1 1 5F2B A0D4    ; Seq 5 Read: Sense_en activated

;--- Read Block for Sequence 3 (A = 50, A_bar = A1, Data = 4C36, data_bar = B3C9) ---
34    0 50 A1 0 0 0 1 0 4C36 B3C9    ; Seq 3 Read: Precharge & SA Precharge activated
35    1 50 A1 0 1 1 0 0 4C36 B3C9    ; Seq 3 Read: Read phase starts
35.5  0 50 A1 0 0 0 1 1 4C36 B3C9    ; Seq 3 Read: Sense_en activated

;--- Read Block for Sequence 2 (A = B0, A_bar = 41, Data = 211B, data_bar = DEE4) ---
36    0 B0 41 0 0 0 1 0 211B DEE4    ; Seq 2 Read: Precharge & SA Precharge activated
37    1 B0 41 0 1 1 0 0 211B DEE4    ; Seq 2 Read: Read phase starts
37.5  0 B0 41 0 0 0 1 1 211B DEE4    ; Seq 2 Read: Sense_en activated

;--- Read Block for Sequence 7 (A = 31, A_bar = C0, Data = FF83, data_bar = 007C) ---
38    0 31 C0 0 0 0 1 0 FF83 007C    ; Seq 7 Read: Precharge & SA Precharge activated
39    1 31 C0 0 1 1 0 0 FF83 007C    ; Seq 7 Read: Read phase starts
39.5  0 31 C0 0 0 0 1 1 FF83 007C    ; Seq 7 Read: Sense_en activated

;--- Read Block for Sequence 9 (A = D1, A_bar = 20, Data = 1A2B, data_bar = E5D4) ---
40    0 D1 20 0 0 0 1 0 1A2B E5D4    ; Seq 9 Read: Precharge & SA Precharge activated
41    1 D1 20 0 1 1 0 0 1A2B E5D4    ; Seq 9 Read: Read phase starts
41.5  0 D1 20 0 0 0 1 1 1A2B E5D4    ; Seq 9 Read: Sense_en activated

;--- Read Block for Sequence 3 (2nd occurrence, A = 50, A_bar = A1, Data = 4C36, data_bar = B3C9) ---
42    0 50 A1 0 0 0 1 0 4C36 B3C9    ; Seq 3 Read (2nd): Precharge & SA Precharge activated
43    1 50 A1 0 1 1 0 0 4C36 B3C9    ; Seq 3 Read (2nd): Read phase starts
43.5  0 50 A1 0 0 0 1 1 4C36 B3C9    ; Seq 3 Read (2nd): Sense_en activated

;--- Read Block for Sequence 4 (A = 91, A_bar = 60, Data = E15C, data_bar = 1EA3) ---
44    0 91 60 0 0 0 1 0 E15C 1EA3    ; Seq 4 Read: Precharge & SA Precharge activated
45    1 91 60 0 1 1 0 0 E15C 1EA3    ; Seq 4 Read: Read phase starts
45.5  0 91 60 0 0 0 1 1 E15C 1EA3    ; Seq 4 Read: Sense_en activated

;--- Read Block for Sequence 1 (A = 50, A_bar = A1, Data = 984C, data_bar = 67B3) ---
46    0 50 A1 0 0 0 1 0 984C 67B3    ; Seq 1 Read: Precharge & SA Precharge activated
47    1 50 A1 0 1 1 0 0 984C 67B3    ; Seq 1 Read: Read phase starts
47.5  0 50 A1 0 0 0 1 1 984C 67B3    ; Seq 1 Read: Sense_en activated

;--- Read Block for Sequence 8 (A = 81, A_bar = 70, Data = 19D7, data_bar = E628) ---
48    0 81 70 0 0 0 1 0 19D7 E628    ; Seq 8 Read: Precharge & SA Precharge activated
49    1 81 70 0 1 1 0 0 19D7 E628    ; Seq 8 Read: Read phase starts
49.5  0 81 70 0 0 0 1 1 19D7 E628    ; Seq 8 Read: Sense_en activated

;--- Read Block for Sequence 5 (2nd occurrence, A = F1, A_bar = 00, Data = 5F2B, data_bar = A0D4) ---
50    0 F1 00 0 0 0 1 0 5F2B A0D4    ; Seq 5 Read (2nd): Precharge & SA Precharge activated
51    1 F1 00 0 1 1 0 0 5F2B A0D4    ; Seq 5 Read (2nd): Read phase starts
51.5  0 F1 00 0 0 0 1 1 5F2B A0D4    ; Seq 5 Read (2nd): Sense_en activated
```
---

## Layout

### SRAM 1bit
![Layout_SRAM1bit_sch](images/layout/Layout_SRAM1bit_sch.png)
![Layout_SRAM1bit_drc](images/layout/Layout_SRAM1bit_drc.png)
![Layout_SRAM1bit_lvs](images/layout/Layout_SRAM1bit_lvs.png)

### PreCharge 1bit
#### Note: DRC Soft error due to missing nwell will be fixed in the top level SRAM Bank layout
![Layout_PreCharge1bit_sch](images/layout/Layout_PreCharge1bit_sch.png)
![Layout_PreCharge1bit_drc](images/layout/Layout_PreCharge1bit_drc.png)
![Layout_PreCharge1bit_lvs](images/layout/Layout_PreCharge1bit_lvs.png)

### ColumnMux 1bit
![Layout_ColMux1bit_sch](images/layout/Layout_ColMux1bit_sch.png)
![Layout_ColMux1bit_drc](images/layout/Layout_ColMux1bit_drc.png)
![Layout_ColMux1bit_lvs](images/layout/Layout_ColMux1bit_lvs.png)

### PowerStripe Cell
![Layout_PowerStripe](images/layout//Layout_PowerStripe.png)

## SRAM Bank Layout (SKILL Script Output)
### Skill Script
This skill script is designed for **Cadence Virtuoso** and automates the generation of an SRAM layout by placing different types of cells (SRAM bitcells, precharge cells, column muxes) in a structured array. Here's a breakdown and explanation of the key components of the script:

---

### **Initialization and Parameters**
These are the physical layout parameters and cell names defined for use throughout the script:

```lisp
; SRAM cell parameters
cellOverlapVerticalP = 0.24
cellOverlapVerticalG = 0.14
cellOverlapHori = 0
cellHeight = 1.98
cellWidth = 1.12
boundarytoTop = cellOverlapVerticalP/2
boundarytoLeft = cellOverlapHori/2
```
These define overlaps and sizes to avoid DRC violations and ensure proper spacing during cell placement.

```lisp
; Other cell dimensions
PWRSTRIPE_cellwidth = 0.52
pre_cellHeight = 0.91
WE_cellWidth = 0
Mux_cellHeight = 1.405
```

```lisp
; Cell names and library
lib_name = "PRELAB-C"
working_cell = "SRAM_Pre_Mux_v2"
PWRSTRIPE_cell = "PowerStripe"
SRAM_cell = "SRAM_1bit"
PRE_cell = "PreCharge_1bit"
WE_cell = "AND2"
ColMux_Cell = "ColumnMux_1bit"
```

---

### **`genSRAMArray` Procedure**
```lisp
procedure(genSRAMArray(row, column)
```
This is the main procedure that generates the SRAM array. You pass the number of rows and columns to it.

- It opens the **schematic and layout views** of the working SRAM cell.
- Calls `placeComponentArray` multiple times to:
  - Place **SRAM cells**
  - Place **Precharge cells**
  - (Commented out) Wordline enable cells
  - Place **MUX cells**

Placement locations are determined relative to the origin, using `boundarytoTop` and the cell heights.

---

### **`placeComponentArray` Procedure**
```lisp
procedure(placeComponentArray(row, column, x_index, y_index, component_name, PWRSTRIPE_cell, pwr)
```
This handles the core cell placement logic.

- It loops over rows and columns to place the given component (`component_name`) in an array.
- Alternates vertical overlap between `cellOverlapVerticalP` and `cellOverlapVerticalG` based on even or odd row (`isEvenRow`).
- Uses `cellCreate()` (presumably a user-defined function in `myFunctions.il`) to instantiate cells.
- Tracks bounding box (`bBox`) to determine where the next cell should be placed.
- Optionally places **PowerStripe** cells at the end of each row if `pwr == 1`.

### Full SKILL Script
```lisp
load("/home/viterbi/04/shauryac/work_gpdk045/SCRIPTS/myFunctions.il") ;<--your path

; basic dimensions of the SRAM cell 
cellOverlapVerticalP = 0.24
cellOverlapVerticalG = 0.14
cellOverlapHori = 0
cellHeight = 1.98
cellWidth = 1.12
boundarytoTop = cellOverlapVerticalP/2
boundarytoLeft = cellOverlapHori/2

; Power stripe cell dimension
PWRSTRIPE_cellwidth = 0.52

; Precharge cell dimension
pre_cellHeight = 0.91

; Wordline Enable cell dimension
WE_cellWidth = 0

; Mux cell dimention
Mux_cellHeight = 1.405

; initialize lib name, working cell name, and cell components names
lib_name = "PRELAB-C"                   ; the library name for which includes all your memory cell components
working_cell = "SRAM_Pre_Mux_v2"        ; the cell name for which you are currently working on
PWRSTRIPE_cell = "PowerStripe"          ; the cell name for the power stripe
SRAM_cell = "SRAM_1bit"                 ; the cell name for your SRAM bit cell
PRE_cell = "PreCharge_1bit"             ; the cell name for your precharge circuit
WE_cell = "AND2"                        ; the cell name for your wordline enable circuit
ColMux_Cell = "ColumnMux_1bit"          ; the cell name for your column mux


procedure(genSRAMArray(row, column)
    cell = working_cell
    lib = lib_name

    cvSch=dbOpenCellViewByType(lib cell "schematic" "schematic" "r")
    ; cvLay=lxGenFromSource(cvSch ?layViewName "layout" ?extractAfterGenerateAll t ?initCreateBoundary nil )
    cvLay=dbOpenCellViewByType(lib cell "layout" "maskLayout" "a")
    
    geOpen(?lib lib ?cell cell ?view "layout" ?mode "a")
    deInstallApp(getCurrentWindow() "Virtuoso XL")

    ; Place SRAM cells
    placeComponentArray(row, column, 0, -boundarytoTop, SRAM_cell, PWRSTRIPE_cell, 1)

    ; Place Precharge cells
    placeComponentArray(1, column, 0, pre_cellHeight - cellOverlapVerticalP , PRE_cell, PWRSTRIPE_cell, 0)

    ; Dont Place WE cells
    ;placeComponentArray(row, 1, - WE_cellWidth, -boundarytoTop, WE_cell, PWRSTRIPE_cell, 0)

    ; Place MUX cells
    placeComponentArray(1, column, 0, -cellHeight*row-boundarytoTop, ColMux_Cell, PWRSTRIPE_cell, 0)
)

procedure(placeComponentArray(row, column, x_index, y_index, component_name, PWRSTRIPE_cell, pwr)
    oldRight = x_index
    oldBottom = y_index
    count = 0
    rowCount = 0
    colCount = 0
    for(i 1 row
        oldRight = x_index - boundarytoLeft
        isEvenRow = mod(rowCount 2)
        for(j 1 column
            if((isEvenRow ==0) cellCreate(component_name, oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalP, 0, 0))
            if((isEvenRow ==1) cellCreate(component_name, oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalG, 0, 1))

            oldRight =  car(cadr(cellInst~>bBox))
            count = count + 1
            colCount = colCount + 1
        )
        rowCount = rowCount + 1
        if(((isEvenRow == 0) && (pwr == 1)) cellCreate("PowerStripe", oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalP, 0, 0))
        if(((isEvenRow == 1) && (pwr == 1)) cellCreate("PowerStripe", oldRight - cellOverlapHori, oldBottom + cellOverlapVerticalG, 0, 1))
        oldBottom = cadr(car(cellInst~>bBox))
    )
    
    lxUpdateBinding(cvLay ?schCV cvSch)
)
```
### Skill Script Output

![Layout_ColMux1bit_sch](images/layout/Layout_SRAMBankSkill_sch.png)
![Layout_ColMux1bit_drc](images/layout/Layout_SRAMBankSkill_drc.png)
![Layout_ColMux1bit_lvs](images/layout/Layout_SRAMBankSkill_lvs.png)

## *Peripheral Circuitry*

### Column Decoder (2to4)
![Layout_ColDecoder_sch](images/layout/Layout_ColDecoder_sch.png)
![Layout_ColDecoder_drc](images/layout/Layout_ColDecoder_drc.png)
![Layout_ColDecoder_lvs](images/layout/Layout_ColDecoder_lvs.png)

### Row Decoder (3to8)
![Layout_RowDecoder_sch](images/layout/Layout_RowDecoder_sch.png)
![Layout_RowDecoder_drc](images/layout/Layout_RowDecoder_drc.png)
![Layout_RowDecoder_lvs](images/layout/Layout_RowDecoder_lvs.png)

### Write Driver
![Layout_WriteDriver_sch](images/layout/Layout_WriteDriver_sch.png)
![Layout_WriteDriver_drc](images/layout/Layout_WriteDriver_drc.png)
![Layout_WriteDriver_lvs](images/layout/Layout_WriteDriver_lvs.png)

### Sense Amplifier with NAND Latch & Output Register (DFF)
![Layout_SenseAmp_sch](images/layout/Layout_SenseAmp_sch.png)
![Layout_SenseAmp_drc](images/layout/Layout_SenseAmp_drc.png)
![Layout_SenseAmp_lvs](images/layout/Layout_SenseAmp_lvs.png)

### Address Register 1bit (DFF)
![Layout_DFF_sch](images/layout/Layout_DFF_sch.png)
---

### SRAM Bank with Column Decoder
#### *This is extracted and made into a symbol to be used in TB*

![Layout_SRAMBank_ColDecoder_symbol](images/layout/Layout_SRAMBank_ColDecoder_symbol.png)
![Layout_SRAMBank_ColDecoder_sch](images/layout/Layout_SRAMBank_ColDecoder_sch.png)
![Layout_SRAMBank_ColDecoder_drc](images/layout/Layout_SRAMBank_ColDecoder_drc.png)
![Layout_SRAMBank_ColDecoder_lvs](images/layout/Layout_SRAMBank_ColDecoder_lvs.png)

## SRAM Bank TB
#### *The extracted views are selected in the testbench config file and then this config view is selected in the maestro*
![Layout_SRAMBank_TB_sch](images/layout/Layout_SRAMBank_TB_sch.png)
![Layout_SRAMBank_TB_config](images/layout/Layout_SRAMBank_TB_config.png)
![Layout_SRAMBank_TB_maestro](images/layout/Layout_SRAMBank_TB_maestro.png)

### SRAM Bank Vector File

```lisp
; // Vector File for SRAM Bank Layout with 4-bit Data Bus (Radix 4 for data)

radix 1 41 41 1 1 1 1 1 4 4
io    i ii ii i i i i i i i
vname precharge_en A<[4:0]> A_bar<[4:0]> write_en decoder_en pre_en_SA read_en sense_en data<[3:0]> data_bar<[3:0]>
tunit ns
slope 0.01
vih 1.0
vil 0.0

; //=====================================================================
; // WRITE MSB OPERATIONS (Order: 5, 6, 7, 8, 9, 0, 1, 2, 3, 4)
; //=====================================================================

;--- Sequence 5: A = F1, A_bar = 00, MSB of Data = 5F2B, data_bar = A0D4 ---
0    1 F1 00 0 0 1 1 0 5 A    ; Seq 5 Write: Initial Condition, Everything disabled
2    0 F1 00 0 0 1 1 0 5 A    ; Seq 5 Write: Precharge and Present Address & Data
3    1 F1 00 1 0 1 1 0 5 A    ; Seq 5 Write: Write Enable activated (precharge deactivated)
4    1 F1 00 1 1 1 1 0 5 A    ; Seq 5 Write: DECODER_EN activated

;--- Sequence 6: A = A0, A_bar = 51, MSB of Data = 9054, data_bar = 6FAB ---
5    0 A0 51 0 0 1 1 0 9 6    ; Seq 6 Write: Precharge and Present Address & Data
6    1 A0 51 1 0 1 1 0 9 6    ; Seq 6 Write: Write Enable activated
7    1 A0 51 1 1 1 1 0 9 6    ; Seq 6 Write: DECODER_EN activated

;--- Sequence 7: A = 31, A_bar = C0, MSB of Data = FF83, data_bar = 007C ---
8    0 31 C0 0 0 1 1 0 F 0    ; Seq 7 Write: Precharge and Present Address & MSB of Data
9    1 31 C0 1 0 1 1 0 F 0    ; Seq 7 Write: Write Enable activated
10   1 31 C0 1 1 1 1 0 F 0    ; Seq 7 Write: DECODER_EN activated

;--- Sequence 8: A = 81, A_bar = 70, MSB of Data = 19D7, data_bar = E628 ---
11   0 81 70 0 0 1 1 0 1 E    ; Seq 8 Write: Precharge and Present Address & MSB of Data
12   1 81 70 1 0 1 1 0 1 E    ; Seq 8 Write: Write Enable activated
13   1 81 70 1 1 1 1 0 1 E    ; Seq 8 Write: DECODER_EN activated

;--- Sequence 9: A = D1, A_bar = 20, MSB of Data = 1A2B, data_bar = E5D4 ---
14   0 D1 20 0 0 1 1 0 1 E    ; Seq 9 Write: Precharge and Present Address & MSB of Data
15   1 D1 20 1 0 1 1 0 1 E    ; Seq 9 Write: Write Enable activated
16   1 D1 20 1 1 1 1 0 1 E    ; Seq 9 Write: DECODER_EN activated

;--- Sequence 0: A = 51, A_bar = A0, MSB of Data = 143B, data_bar = EBC4 ---
17   0 51 A0 0 0 1 1 0 1 E    ; Seq 0 Write: Precharge and Present Address & MSB of Data
18   1 51 A0 1 0 1 1 0 1 E    ; Seq 0 Write: Write Enable activated
19   1 51 A0 1 1 1 1 0 1 E    ; Seq 0 Write: DECODER_EN activated

;--- Sequence 1: A = 50, A_bar = A1, MSB of Data = 984C, data_bar = 67B3 ---
20   0 50 A1 0 0 1 1 0 9 6    ; Seq 1 Write: Precharge and Present Address & MSB of Data
21   1 50 A1 1 0 1 1 0 9 6    ; Seq 1 Write: Write Enable activated
22   1 50 A1 1 1 1 1 0 9 6    ; Seq 1 Write: DECODER_EN activated

;--- Sequence 2: A = B0, A_bar = 41, MSB of Data = 211B, data_bar = DEE4 ---
23   0 B0 41 0 0 1 1 0 2 D    ; Seq 2 Write: Precharge and Present Address & MSB of Data
24   1 B0 41 1 0 1 1 0 2 D    ; Seq 2 Write: Write Enable activated
25   1 B0 41 1 1 1 1 0 2 D    ; Seq 2 Write: DECODER_EN activated

;--- Sequence 3: A = 50, A_bar = A1, MSB of Data = 4C36, data_bar = B3C9 ---
26   0 50 A1 0 0 1 1 0 4 B    ; Seq 3 Write: Precharge and Present Address & MSB of Data
27   1 50 A1 1 0 1 1 0 4 B    ; Seq 3 Write: Write Enable activated
28   1 50 A1 1 1 1 1 0 4 B    ; Seq 3 Write: DECODER_EN activated

;--- Sequence 4: A = 91, A_bar = 60, MSB of Data = E15C, data_bar = 1EA3 ---
29  0 91 60 0 0 1 1 0 E 1    ; Seq 4 Write: Precharge and Present Address & MSB of Data
30  1 91 60 1 0 1 1 0 E 1    ; Seq 4 Write: Write Enable activated
31  1 91 60 1 1 1 1 0 E 1    ; Seq 4 Write: DECODER_EN activated

; //=====================================================================
; // READ MSB OPERATIONS (Faster READ, Order: 5, 3, 2, 7, 9, 3, 4, 1, 8, 5)
; //=====================================================================

;--- Read Block for Sequence 5 (A = F1, A_bar = 00, MSB of Data = 5F2B, data_bar = A0D4) ---
32    0 F1 00 0 0 0 1 0 5 A    ; Seq 5 Read: Precharge & SA Precharge activated
33    1 F1 00 0 1 1 0 0 5 A    ; Seq 5 Read: Read phase starts
33.5  0 F1 00 0 0 0 1 1 5 A    ; Seq 5 Read: Sense_en activated

;--- Read Block for Sequence 3 (A = 50, A_bar = A1, MSB of Data = 4C36, data_bar = B3C9) ---
34    0 50 A1 0 0 0 1 0 4 B    ; Seq 3 Read: Precharge & SA Precharge activated
35    1 50 A1 0 1 1 0 0 4 B    ; Seq 3 Read: Read phase starts
35.5  0 50 A1 0 0 0 1 1 4 B    ; Seq 3 Read: Sense_en activated

;--- Read Block for Sequence 2 (A = B0, A_bar = 41, MSB of Data = 211B, data_bar = DEE4) ---
36    0 B0 41 0 0 0 1 0 2 D    ; Seq 2 Read: Precharge & SA Precharge activated
37    1 B0 41 0 1 1 0 0 2 D    ; Seq 2 Read: Read phase starts
37.5  0 B0 41 0 0 0 1 1 2 D    ; Seq 2 Read: Sense_en activated

;--- Read Block for Sequence 7 (A = 31, A_bar = C0, MSB of Data = FF83, data_bar = 007C) ---
38    0 31 C0 0 0 0 1 0 F 0    ; Seq 7 Read: Precharge & SA Precharge activated
39    1 31 C0 0 1 1 0 0 F 0    ; Seq 7 Read: Read phase starts
39.5  0 31 C0 0 0 0 1 1 F 0    ; Seq 7 Read: Sense_en activated

;--- Read Block for Sequence 9 (A = D1, A_bar = 20, MSB of Data = 1A2B, data_bar = E5D4) ---
40    0 D1 20 0 0 0 1 0 1 E    ; Seq 9 Read: Precharge & SA Precharge activated
41    1 D1 20 0 1 1 0 0 1 E    ; Seq 9 Read: Read phase starts
41.5  0 D1 20 0 0 0 1 1 1 E    ; Seq 9 Read: Sense_en activated

;--- Read Block for Sequence 3 (2nd occurrence, A = 50, A_bar = A1, MSB of Data = 4C36, data_bar = B3C9) ---
42    0 50 A1 0 0 0 1 0 4 B    ; Seq 3 Read (2nd): Precharge & SA Precharge activated
43    1 50 A1 0 1 1 0 0 4 B    ; Seq 3 Read (2nd): Read phase starts
43.5  0 50 A1 0 0 0 1 1 4 B    ; Seq 3 Read (2nd): Sense_en activated

;--- Read Block for Sequence 4 (A = 91, A_bar = 60, MSB of Data = E15C, data_bar = 1EA3) ---
44    0 91 60 0 0 0 1 0 E 1    ; Seq 4 Read: Precharge & SA Precharge activated
45    1 91 60 0 1 1 0 0 E 1    ; Seq 4 Read: Read phase starts
45.5  0 91 60 0 0 0 1 1 E 1    ; Seq 4 Read: Sense_en activated

;--- Read Block for Sequence 1 (A = 50, A_bar = A1, MSB of Data = 984C, data_bar = 67B3) ---
46    0 50 A1 0 0 0 1 0 9 6    ; Seq 1 Read: Precharge & SA Precharge activated
47    1 50 A1 0 1 1 0 0 9 6    ; Seq 1 Read: Read phase starts
47.5  0 50 A1 0 0 0 1 1 9 6    ; Seq 1 Read: Sense_en activated

;--- Read Block for Sequence 8 (A = 81, A_bar = 70, MSB of Data = 19D7, data_bar = E628) ---
48    0 81 70 0 0 0 1 0 1 E    ; Seq 8 Read: Precharge & SA Precharge activated
49    1 81 70 0 1 1 0 0 1 E    ; Seq 8 Read: Read phase starts
49.5  0 81 70 0 0 0 1 1 1 E    ; Seq 8 Read: Sense_en activated

;--- Read Block for Sequence 5 (2nd occurrence, A = F1, A_bar = 00, MSB of Data = 5F2B, data_bar = A0D4) ---
50    0 F1 00 0 0 0 1 0 5 A    ; Seq 5 Read (2nd): Precharge & SA Precharge activated
51    1 F1 00 0 1 1 0 0 5 A    ; Seq 5 Read (2nd): Read phase starts
51.5  0 F1 00 0 0 0 1 1 5 A    ; Seq 5 Read (2nd): Sense_en activated
```
### Simulation Output
#### Functionality Verified
#### *Note: Signal name <DATA_OUT_HEX> is the output of the Flip Flop*
![Layout_SRAMBank_TB_graph](images/layout/Layout_SRAMBank_TB_graph.png)

## SRAM Bank Layout Datasheet

## 1GHz Clk Frequency

| **Parameter**                          | **Value**       | **Description**                                                                 |
|----------------------------------------|-----------------|---------------------------------------------------------------------------------|
| **Clock Period**                       | 1 ns            | Clock period as defined in Maestro                                              |

### Write Operation Delays

| Parameter                              | Value           | Description                                                                     |
|----------------------------------------|-----------------|---------------------------------------------------------------------------------|
| Precharge Time                         | 428.7 ps        | Time for bit lines to precharge (≈0.95 V) before write operations.              |
| Decoder Delay                          | 27.87 ps        | Delay from WL enable to decoder output activation.                              |
| WL-to-Q Flip Delay                     | 82.39 ps        | Delay from WL activation to the cell’s internal node (Q) switching.             |
| **Total Write Delay**                  | 110.26 ps       | Sum of Decoder Delay and WL-to-Q Flip Delay.                                    |

### Read Operation Delays

| Parameter                              | Value           | Description                                                                     |
|----------------------------------------|-----------------|---------------------------------------------------------------------------------|
| Bitline Discharge Delay                | 61.16 ps        | Time from `read_en` activation until the bitline discharges to 0.9 V.           |
| Sense Amplifier Delay                  | 85.37 ps        | Delay from `sense_en` to SA output latching the sensed value.                   |
| **Total Read Delay**                   | 146.53 ps       | Sum of Bitline Discharge Delay and Sense Amplifier Delay.                       |

### Area & Energy Metrics

| Parameter                              | Value           | Description                                                                     |
|----------------------------------------|-----------------|---------------------------------------------------------------------------------|
| **SRAM Bank Area**                     | 592.9584 µm²    | Total physical area of the SRAM array.                                          |
| **Clock Frequency**                    | 1 GHz           | Operating frequency of the SRAM.                                                |
| **Average Read Energy**                | 307.178 µJ      | Average energy consumed per read operation.                                     |
| **Average Write Energy**               | 59.145 µJ       | Average energy consumed per write operation.                                    |
| **Average Leakage Energy**             | 206.631 µJ      | Static leakage energy consumed when idle.                                       |


