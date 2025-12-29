## 📡 RF Coupler Design Project – Branch-Line & Rat-Race Couplers (ADS)

This project showcases the **design, simulation, and EM verification of RF quadrature couplers** using **transmission-line theory and microstrip implementations**. It was completed as **ADS Project 1** for **ESE4330: RF Electronics** at Washington University in St. Louis.

### 📌 Project Summary

- Designed two RF power-splitting couplers:
  - **3 dB Branch-Line Coupler @ 2 GHz**
  - **6 dB Rat-Race Coupler @ 3 GHz**
- Implemented and analyzed:
  - **Ideal transmission-line models**
  - **Microstrip implementations**
  - **Full-wave Momentum EM simulations**
- Verified correct **power split, isolation, and phase relationships** across frequency.

---

### 🔧 Key RF Design Features

- **Branch-Line Coupler (Quadrature Hybrid)**:
  - Equal 3 dB power split
  - ~90° phase difference between output ports
  - High isolation and low return loss
- **Rat-Race Coupler (180° Hybrid)**:
  - 6 dB coupling
  - Output ports in phase with each other
  - Isolated port with expected 180° phase behavior
- **Transmission-Line Theory**:
  - Analytical derivation of characteristic impedances
  - Quarter- and half-wavelength sections
- **Microstrip Realization**:
  - Line widths and lengths computed using **ADS LineCalc**
  - 50 Ω feed lines for all ports

---

### 📊 Simulation & Verification

- **S-Parameter Analysis**:
  - Verified |S21| and |S31| coupling levels
  - Confirmed low |S11| return loss and strong isolation
- **Phase Analysis**:
  - Branch-line: ~90° phase difference between outputs
  - Rat-race: In-phase outputs with expected quadrature relationships
- **Momentum EM Simulation**:
  - Compared schematic-level microstrip simulations to EM results
  - Observed realistic magnitude degradation due to layout parasitics
- Determined that **schematic-level simulations were sufficient** for validating coupler behavior, with EM simulations primarily capturing layout effects.

---
