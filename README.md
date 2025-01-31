# Stopwatch on FPGA (Basys 3)

## Project Overview
This project implements a **digital stopwatch** on the **Basys 3 FPGA** board using **SystemVerilog**. The stopwatch includes start, stop, reset, and lap time functionality, and displays the time on the **7-segment display**. The project is a **course assignment** for the subject **Digital Electronics Circuits**.

## Features
- **Start/Stop**: Toggle the stopwatch on and off.
- **Reset**: Clear the time and reset the stopwatch.
- **Lap Time**: Store and display the last recorded time.
- **7-Segment Display Output**: Shows the time in seconds and hundredths of a second (SS:MS).
- **Binary Display Output**: Shows the time in minutes coded in binary system.
- **Clock Divider**: Generates a 100Hz signal from the onboard 100MHz clock.

## Hardware & Software Requirements
- **Basys 3 FPGA Board** (Xilinx Artix-7)
- **Vivado Design Suite** (by Xilinx)
- **SystemVerilog** for hardware description

## Implementation Details
1. **Clock Divider**: Converts the 100MHz clock signal to 100Hz for timing.
2. **Counter Module**: Keeps track of elapsed time in minutes and seconds.
3. **Control Logic**: Implements start, stop, reset, and lap time functionality.
4. **Multiplexing Display**: Manages the 7-segment display output.

## Controls
- **BTNU (Start)**: Press to start the stopwatch.
- **BTNC (Reset)**: Press to reset the stopwatch.
- **BTND (Stop)**: Press to stop the stopwatch.
- **BTNL (Lap Time)**: Press to store the current time.

## How to Run the Project
1. Open **Vivado** and create a new project.
2. Import the provided **SystemVerilog** files.
3. Synthesize and implement the design.
4. Generate the **bitstream** and upload it to the **Basys 3** board.
5. Use the buttons to operate the stopwatch.

## Future Improvements
- Implement 7-segment brightness control.

## Author
Krzysztof Baumgart - Digital Electronics Circuits Course Project

