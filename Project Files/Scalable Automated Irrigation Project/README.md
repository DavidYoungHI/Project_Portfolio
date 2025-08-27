## Wireless Irrigation System Project

This repository contains files related to my **Wireless Irrigation System Project**, developed for greenhouse automation using the ESP32 and Raspberry Pi.

- 🌱 **Project Overview** – Designed a wireless, closed-loop irrigation system for tomato plants using capacitive moisture sensors and solenoid-controlled valves.
- 🔧 **Arduino Control Code** – [`ESE498ESP32.ino`](./ESE498ESP32.ino): ESP32 code for reading moisture levels from multiple sensors via an analog multiplexer and transmitting data via MQTT to a Raspberry Pi.
- 🧠 **Capstone Final Report** – [`ESE498CapstoneReport.pdf`](./ESE498CapstoneReport.pdf): Full documentation detailing system evolution, sensor calibration, and design iterations.
- 📊 **Capstone Poster Presentation** – [`Capstone poster.pdf`](./Capstone%20poster.pdf): A condensed visual summary prepared for public showcase and evaluation.

📌 The ESP32 reads from three capacitive moisture sensors and dynamically adjusts irrigation timing based on real-time moisture levels. In the future, we plan to complete the GUI to enable remote monitoring and manual override.

📈 Over a 7-day testing period, the system successfully maintained ~80% soil moisture across all plants without human intervention.
