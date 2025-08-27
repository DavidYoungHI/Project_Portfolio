## UAV Control System Project (Quadrotor) 🚁

This directory contains the complete **UAV Cascaded Controller Design Project** developed in MATLAB and Simulink for a nonlinear quadrotor drone system.

### 📂 Contents
- 📄 **Final Project Report** – [`DavidYESE4481FinalReport.pdf`](./DavidYESE4481FinalReport.pdf)  
  Describes modeling, linearization, controllability, controller design, simulation setup, and analysis of the quadrotor response using cascaded control.
  
- 🧠 **Drone Dynamics Model (Nonlinear)** – [`Non_lin_DroneDynam_WithActuator.slx`](./Non_lin_DroneDynam_WithActuator.slx)  
  Simulink model of the full nonlinear dynamics of the drone including actuator behavior.

- 🧮 **Drone Dynamics Model (Linearized)** – [`DroneDynam_WithActuator.slx`](./DroneDynam_WithActuator.slx)  
  Linear approximation used for controller design and response analysis.

- 🧪 **Simulink Control Architecture** – [`ESE4481Simulink.slx`](./ESE4481Simulink.slx)  
  Full block diagram combining the drone model with Z, L, M, and N controllers and test inputs.

- ⚙️ **Controllers (Z, L, M, N)** –  
  - [`ESE4481ZController.slx`](./ESE4481ZController.slx)  
  - [`ESE4481LController.slx`](./ESE4481LController.slx)  
  - [`ESE4481MController.slx`](./ESE4481MController.slx)  
  - [`ESE4481NController.slx`](./ESE4481NController.slx)  
  Each implements a cascaded controller using nested loops for position, velocity, angle, and rate control in one axis.

- 🔢 **Live Script (Analysis & Derivations)** – [`ESE4481FinalProjectCode.mlx`](./ESE4481FinalProjectCode.mlx)  
  MATLAB live script used to derive linearized matrices, perform trimming, and design gain values.

---

📌 **Project Highlights**
- Modeled a nonlinear quadrotor using 12 state variables and 6 control inputs.
- Linearized the system around hover conditions and verified controllability.
- Designed cascaded controllers in all four directions (Z, roll, pitch, yaw) based on measurement frequency and desired bandwidth.
- Simulated system step responses to verify control performance.
- Developed a mixer to convert control outputs into PWM signals for motors.

