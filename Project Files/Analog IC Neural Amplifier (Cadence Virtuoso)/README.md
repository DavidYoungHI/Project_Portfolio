## 🧠 Analog IC Design Project – CMOS Neural Amplifier

This project presents the **design, simulation, and analysis of a low-noise CMOS neural amplifier** intended for **biomedical signal acquisition**. The design emphasizes tradeoffs between **gain, bandwidth, noise, stability, and power consumption**, and was completed for **ESE5620: Analog Integrated Circuit Design** at Washington University in St. Louis.

- 📐 **Design Reference**  
  Inspired by Harrison & Charles, *“A Low-Power Low-Noise CMOS Amplifier for Neural Recording Applications”* (IEEE JSSC).

---

### 📌 Project Summary

- Designed a **CMOS operational transconductance amplifier (OTA)** and integrated it into a **capacitor-feedback neural amplifier**
- Targeted performance suitable for neural recording:
  - High gain
  - Sub-Hz low-frequency cutoff
  - Stable phase margin
- Evaluated amplifier robustness across **temperature variation**, **noise sources**, and **biasing conditions**

---

### 🔧 Key Analog IC Features

- **Operational Transconductance Amplifier (OTA)**:
  - Fully custom transistor-level design
  - Gain > 40 dB and stable phase margin (~56°)
- **Bias & Reference Circuit**:
  - Designed to generate ~100 µA bias current
  - Verified through transient simulations
- **Capacitor-Feedback Neural Amplifier**:
  - Achieved ultra-low-frequency cutoff using large effective resistances
- **Pseudo-Resistor Implementation**:
  - Explored PMOS diode-connected pseudo-resistors
  - Evaluated limitations compared to ideal resistors

---

### 📊 Simulation & Verification

- **AC & Transient Analysis**:
  - Verified gain, bandwidth, and stability
- **Noise Analysis**:
  - Calculated and simulated input-referred noise
  - Identified dominant noise contributors in the input differential pair
- **Temperature Variation Analysis**:
  - Simulated performance at 0 °C, 25 °C, and 50 °C
- **Power Analysis**:
  - Evaluated system-level power dissipation and design tradeoffs

---

### 🧠 Design Highlights

- Strong emphasis on **analog design tradeoffs**:
  - Power vs. noise
  - Bandwidth vs. stability
- Combined **hand analysis** with **Cadence simulations**
- Realistic exploration of challenges in biomedical IC design
- Demonstrated understanding of:
  - Transconductance-based noise optimization
  - Biasing strategies
  - Low-frequency analog circuit behavior

---
