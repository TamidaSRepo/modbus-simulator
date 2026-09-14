# TamidaS Modbus Simulator

[![Website](https://img.shields.io/badge/Website-tamidas.com-1f6feb)](https://www.tamidas.com)
[![User Guide](https://img.shields.io/badge/Docs-User%20Guide%20(PDF)-1a7f37)](Modbus-Simulator-User-Guide.pdf)
[![Price](https://img.shields.io/badge/Price-Free-brightgreen)](https://www.tamidas.com)

A free Modbus **slave/device simulator** that makes your PC behave like one or
more Modbus devices, so a Modbus master — a SCADA system, gateway, PLC, data
logger or your own firmware — can be developed and tested without the real
equipment.

Powered by **[TamidaS](https://www.tamidas.com)** — free tools for engineers.

---

## Overview

The simulator runs as a single Windows executable. When started it opens a local
web interface in your browser where you build and drive the simulated devices;
Modbus masters connect over TCP or a serial line and see them as real slaves.

- **Two transports** — Modbus **TCP** on any port, and Modbus **RTU** over a
  serial line such as a USB-to-RS-485 adapter.
- **Any number of slaves** — each with its own name, slave id, protocol and
  register map. Slaves can share a TCP port or a serial bus, just like real
  devices.
- **All four address spaces** — holding registers, input registers, coils and
  discrete inputs.
- **Function codes** 1, 2, 3, 4, 5, 6, 7, 8, 15, 16, 17, 22 and 23, with correct
  exception responses for everything else.
- **Realistic data** — integers and floats in any byte order (ABCD, CDAB, BADC,
  DCBA), values that change by themselves, counters that increment, coils that
  toggle or pulse.
- **Register maps from files** — upload a CSV or Excel register list; a template
  is included.
- **Full visibility** — every request and response is logged as hex with its
  result, so you can see exactly what the master asked for and what was returned.

## Getting started

1. **Run the program.** Double-click `tamidas-modbus-simulator.exe`. A console
   window opens and shows the web address, and your default browser opens the
   simulator. Keep the console window open; closing it stops the simulator.
2. **Add a slave.** Click **+ Add slave**, choose Modbus TCP or RTU, and save.
3. **Load a register map.** Upload the device's register list (CSV/Excel) or add
   registers by hand.
4. **Connect your master** to the address shown in the slave tab and start
   polling. Watch the request log.

Settings and register maps are stored in a `data` folder created next to the
executable, so everything is back after a restart.

> The web interface uses port `8080` by default. If that port is busy the next
> free port is used and printed in the console window.

## Documentation

The complete user guide is included in this repository:

**[Modbus-Simulator-User-Guide.pdf](Modbus-Simulator-User-Guide.pdf)** — adding
TCP and RTU slaves, register maps, data types and byte order, coils and discrete
inputs, 0-based vs 1-based addressing, importing from a spreadsheet, reading the
request log, function codes and exceptions, testing with a master, the command
line and data folder, and troubleshooting.

## System requirements

- Windows PC (the executable is a standalone Windows build).
- For Modbus RTU: a USB-to-RS-485 adapter (CH340, FTDI, CP210x, etc.).

The program only runs locally and does not connect to the internet. Because the
executable is not code-signed, Windows SmartScreen may show a warning on first
run — choose **More info → Run anyway**.

## License

Free for public use. © TamidaS — [www.tamidas.com](https://www.tamidas.com)
