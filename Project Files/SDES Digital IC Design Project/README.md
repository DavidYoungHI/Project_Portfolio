## 🔐 Digital IC Design Project – Simplified DES CMOS Chip

This project showcases the complete **CMOS chip design and simulation** for implementing the **Simplified Data Encryption Standard (S-DES)** in hardware. It was developed as the final project for **CSE463M: Digital Integrated Circuit Design and Architecture**.

- 📄 **Final Report** – [`ESE463_Project_Report.docx`](./ESE463_Project_Report.docx): Full technical documentation detailing architecture, schematic diagrams, timing plots, and chip layouts.
- 📐 **CMOS Design Specs** – [`Final Project - Simplified DES algorithm CMOS chip design specifications.docx`](./Final%20Project%20-%20Simplified%20DES%20algorithm%20CMOS%20chip%20design%20specifications.docx): Project guidelines and constraints, including pin mappings, timing requirements, layout size, and design objectives.

---

### 📌 Project Summary

- Designed a CMOS chip that performs **Simplified DES encryption** using:
  - 8-bit input block: `11101100`
  - 10-bit key: `1100010110`
- Encryption triggered via **10 MHz clock** and **Enable** pin
- Chip outputs the **encrypted 8-bit result** while `Enable = 1`; outputs all zeros otherwise
- Total chip layout area: ≤ **1.5mm × 1.5mm**

---

### 🔧 Key Hardware Features

- **Custom-built logic gates**:
  - Inverter, NAND, AND, XOR, Buffers
- **Multiplexers (2-to-1)** for S-box selection
- **D Flip-Flops** used in S-Box memory design
- **Permutation and Expansion Blocks** for `IP`, `IP⁻¹`, `P10`, `P8`, `P4`, and `E/P`
- **Two fk Function Blocks**:
  - `fk1` – XORs expanded input with `k1` and runs S-Boxes
  - `fk2` – XORs second round input with `k2`

---

### ⏱️ Timing and Simulation

- Inputs are synchronized with the clock
- `Enable` logic gates the data inputs
- Simulation confirms correct 8-bit output from encryption logic:
  - Input = `11101100`
  - Key = `1100010110`
  - Output = `11001011`
- Output resets to `00000000` when `Enable = 0`

---

### 🧠 Design Highlights

- **S-Box Logic** implemented using **lookup tables (LUTs)**
- Careful **signal stabilization** using serial inverters
- Modular schematic and layout for each function block
- Successfully verified logic timing via **transient simulation**

---

### 📸 Visual Overview

- 💾 **Overall Chip Schematic and Layout**  
- 🔌 **Pin Mapping** with VDD, GND, I/O lines, Enable, and Clock  
- 🧮 **Custom Gate Designs** for all digital logic blocks  
- ⛓ **Encrypted Output Logic** using combinational and sequential logic
