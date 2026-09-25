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

The simulator runs as a single executable on Windows, macOS and Linux. When started it opens a local
web interface in your browser where you build and drive the simulated devices;
Modbus masters connect over TCP or a serial line and see them as real slaves.

- **Three protocols** — Modbus **TCP** on any port, and Modbus **RTU** or Modbus
  **ASCII** over a serial line such as a USB-to-RS-485 adapter. ASCII mode
  (`:` + hex characters + LRC + CR LF, 7E1 by default) covers older PLCs, drives
  and modem links.
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

## Download

| Platform | File in this repository |
|---|---|
| Windows 10/11 (64-bit) | [tamidas-modbus-simulator.exe](tamidas-modbus-simulator.exe) |
| macOS, Apple silicon (M1 and later) — installer | [tamidas-modbus-simulator-1.0.0-macos-arm64.pkg](tamidas-modbus-simulator-1.0.0-macos-arm64.pkg) |
| macOS, Intel — installer | [tamidas-modbus-simulator-1.0.0-macos-x64.pkg](tamidas-modbus-simulator-1.0.0-macos-x64.pkg) |
| macOS, Apple silicon — portable binary | [tamidas-modbus-simulator-1.0.0-macos-arm64.tar.gz](tamidas-modbus-simulator-1.0.0-macos-arm64.tar.gz) |
| macOS, Intel — portable binary | [tamidas-modbus-simulator-1.0.0-macos-x64.tar.gz](tamidas-modbus-simulator-1.0.0-macos-x64.tar.gz) |
| Linux x64 (Ubuntu, Debian, Fedora, …) | [tamidas-modbus-simulator-1.0.0-linux-x64.tar.gz](tamidas-modbus-simulator-1.0.0-linux-x64.tar.gz) |
| Linux arm64 (Raspberry Pi 4/5 64-bit, ARM servers) | [tamidas-modbus-simulator-1.0.0-linux-arm64.tar.gz](tamidas-modbus-simulator-1.0.0-linux-arm64.tar.gz) |

Each file is a self-contained program: no Node.js, no account. The macOS `.pkg` installs the
`tamidas-modbus-simulator` command; every other file runs in place.

**macOS and Linux — easiest:** one command downloads the right build, checks its SHA-256 and installs it
for your user (no root, no Gatekeeper prompt):

```bash
curl -fsSL https://raw.githubusercontent.com/TamidaSRepo/modbus-simulator/main/install.sh | sh
tamidas-modbus-simulator
```

The script is [install.sh](install.sh) in this repository, so you can read it before running it.

## Getting started

1. **Run the program.**
   - **Windows:** double-click `tamidas-modbus-simulator.exe`.
   - **macOS, installer:** double-click the `.pkg` and click through the installer. It is signed,
     notarised and stapled, so no security prompt appears. It installs **TamidaS Modbus Simulator**
     into your Applications folder — open it from Launchpad or the Applications folder and the web
     interface opens in your browser. Quitting it from the Dock stops the simulator. The command
     `tamidas-modbus-simulator` also works from any Terminal if you prefer.
   - **macOS, portable:** use the one-line install above, or unpack the `.tar.gz` and double-click the binary
     (or start it from Terminal: `./tamidas-modbus-simulator-macos-arm64`). These builds are signed and
     notarised too; if macOS asks once about a file downloaded from the internet, click **Open**.
     Apple silicon uses the `arm64` build, Intel the `x64` build.
   - **Linux:** `tar xzf tamidas-modbus-simulator-1.0.0-linux-x64.tar.gz && ./tamidas-modbus-simulator-linux-x64`.
     To use a serial adapter without root, add your user to the `dialout` group.

   A console window opens and shows the web address, and your default browser opens the
   simulator. Keep the console window open; closing it stops the simulator.
2. **Add a slave.** Click **+ Add slave**, choose Modbus TCP, RTU or ASCII, and save.
3. **Load a register map.** Upload the device's register list (CSV/Excel) or add
   registers by hand.
4. **Connect your master** to the address shown in the slave tab and start
   polling. Watch the request log.

Settings and register maps are stored in a `data` folder created next to the
executable (for the macOS `.pkg` install: `~/Library/Application Support/tamidas-modbus-simulator`),
so everything is back after a restart.

> The web interface uses port `8080` by default. If that port is busy the next
> free port is used and printed in the console window.

### Removing the macOS install

The installer also places an uninstaller, since a `.pkg` gives macOS no way to undo itself:

```bash
sudo tamidas-modbus-simulator-uninstall           # remove the program, keep saved slaves
sudo tamidas-modbus-simulator-uninstall --purge   # also delete saved slaves and register maps
```

It removes the app, the command and the installer receipt. The portable `.tar.gz` builds need no
uninstaller — delete the binary.

## Documentation

The complete user guide is included in this repository:

**[Modbus-Simulator-User-Guide.pdf](Modbus-Simulator-User-Guide.pdf)** — adding
TCP, RTU and ASCII slaves, register maps, data types and byte order, coils and discrete
inputs, 0-based vs 1-based addressing, importing from a spreadsheet, reading the
request log, function codes and exceptions, testing with a master, the command
line and data folder, and troubleshooting.

## System requirements

- Windows 10/11 64-bit, macOS 11 or later (Apple silicon or Intel), or a 64-bit Linux (x64 or arm64).
- For Modbus RTU / ASCII: a USB-to-RS-485 adapter (CH340, FTDI, CP210x, etc.) and its driver.

The program only runs locally and does not connect to the internet. The macOS builds are signed
with the TamidaS Developer ID and notarised by Apple. The Windows executable is not code-signed:
SmartScreen may show a warning on first run (choose **More info → Run anyway**).

## License

Free for public use. © TamidaS — [www.tamidas.com](https://www.tamidas.com)
