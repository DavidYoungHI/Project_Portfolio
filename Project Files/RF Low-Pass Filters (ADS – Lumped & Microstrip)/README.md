## 📶 RF Filter Design Project – Lumped & Microstrip Low-Pass Filters (ADS)

This project focuses on the **design, simulation, optimization, and EM verification of RF low-pass filters** using **lumped elements and distributed microstrip implementations**. It was completed as **ADS Project 2** for **ESE4330: RF Electronics** at Washington University in St. Louis.

- 📐 **Design Specifications**  
  - Cutoff frequency: **3 GHz**  
  - Passband ripple: **0.5 dB**  
  - Stopband attenuation: **≥ 15 dB @ 4.5 GHz**  
  - System impedance: **50 Ω**

---

### 📌 Project Summary

- Designed a **4th-order, 0.5 dB ripple Chebyshev low-pass filter**
- Implemented and compared three realizations:
  - **Lumped-element LPF**
  - **Microstrip shunt-stub LPF**
  - **Stepped-impedance microstrip LPF**
- Evaluated performance using **schematic-level ADS simulations** and **Momentum EM simulations**

---

### 🔧 Key RF Design Features

- **Lumped-Element Filter**:
  - Synthesized using normalized Chebyshev prototype values
  - Achieved sharp cutoff and exceeded stopband attenuation requirements
- **Microstrip Shunt-Stub Filter**:
  - Derived using **Richard’s transformations**
  - Converted to a realizable structure using **Kuroda identities**
- **Stepped-Impedance Filter**:
  - Modeled lumped capacitors and inductors as alternating low- and high-impedance transmission lines
  - Designed using calculated electrical lengths and ADS LineCalc
- **Optimization Workflow**:
  - Tuned cutoff frequency, ripple, and attenuation using ADS optimization tools

---

### 📊 Simulation & Verification

- **S-Parameter Analysis**:
  - Verified cutoff frequency, ripple, and attenuation targets
- **Momentum EM Simulation**:
  - Compared schematic-level results to layout-level performance
  - Observed increased insertion loss and ripple due to parasitic junction effects
- **Performance Comparison**:
  - Lumped-element design met all specifications
  - Microstrip designs revealed practical tradeoffs between realizability and ideal filter behavior

---

