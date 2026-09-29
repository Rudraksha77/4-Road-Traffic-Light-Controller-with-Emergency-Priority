# 🚦 4-Road Traffic Light Controller with Emergency Priority

## 📌 Overview

This project implements a **4-Road Traffic Light Controller** using **Verilog HDL** and a **Finite State Machine (FSM)** architecture. The controller manages traffic signals for four roads and provides **emergency vehicle priority** when an emergency is detected on a specific road.

The design was developed and simulated using **Xilinx Vivado** to verify the RTL functionality and state transitions.

## ✨ Features

* 🚦 Controls traffic signals for **4 roads**
* 🔴 Red, 🟡 Yellow, and 🟢 Green signal control
* ⚙️ FSM-based RTL architecture
* ⏱️ Counter-based configurable signal timing
* 🚑 Emergency vehicle priority
* 🔄 Automatic transition between traffic states
* 🧩 Independent emergency inputs for each road
* 🖥️ RTL simulation using Xilinx Vivado
* 💻 Synthesizable Verilog HDL design

## 🛠️ Technologies Used

| Technology    | Purpose                |
| ------------- | ---------------------- |
| Verilog HDL   | RTL Design             |
| FSM           | Traffic Control Logic  |
| Digital Logic | Signal Control         |
| Xilinx Vivado | Simulation & Synthesis |

## 🏗️ System Architecture

The controller consists of the following major blocks:

```text
                 +----------------------+
                 |    Clock & Reset     |
                 +----------+-----------+
                            |
                            v
                 +----------------------+
                 |   FSM Controller     |
                 +----------+-----------+
                            |
             +--------------+--------------+
             |              |              |
             v              v              v
      +------------+  +------------+  +------------+
      |   Timing   |  | Emergency  |  |   Signal   |
      |  Counter   |  |   Logic    |  |   Control  |
      +------------+  +------------+  +------------+
             |              |              |
             +--------------+--------------+
                            |
                            v
              +---------------------------+
              |  4-Road Traffic Signals   |
              | A | B | C | D             |
              +---------------------------+
```

## 🚥 Traffic Signal Operation

Under normal conditions, each road receives a green signal sequentially.

Example sequence:

```text
Road A → Road B → Road C → Road D → Road A → ...
```

Each road follows:

```text
GREEN → YELLOW → RED
```

while the other roads remain RED.

## 🚑 Emergency Vehicle Priority

The controller supports emergency inputs for all four roads:

```text
emergency_a
emergency_b
emergency_c
emergency_d
```

When an emergency vehicle is detected on a road, the controller gives priority to that road after performing the required safe signal transition.

Example:

```text
Emergency on Road C
        ↓
Current traffic phase completes/safely transitions
        ↓
Road C → GREEN
Road A → RED
Road B → RED
Road D → RED
        ↓
Emergency cleared
        ↓
Normal traffic sequence resumes
```

## 🔌 Inputs and Outputs

### Inputs

| Signal        | Description                  |
| ------------- | ---------------------------- |
| `clk`         | System clock                 |
| `rst`         | Reset signal                 |
| `emergency_a` | Emergency request for Road A |
| `emergency_b` | Emergency request for Road B |
| `emergency_c` | Emergency request for Road C |
| `emergency_d` | Emergency request for Road D |

### Outputs

Each road has three traffic signals:

```text
Road A → a_red, a_yellow, a_green
Road B → b_red, b_yellow, b_green
Road C → c_red, c_yellow, c_green
Road D → d_red, d_yellow, d_green
```

## 📁 Project Structure

```text
4-road-traffic-light-controller/
│
├── traffic_light_controller.v
├── traffic_light_controller_tb.v
├── README.md
└── simulation/
```

## 🔄 FSM States

The controller uses FSM states to control the traffic sequence.

```text
        +--------+
        | Road A |
        +---+----+
            |
            v
        +--------+
        | Road B |
        +---+----+
            |
            v
        +--------+
        | Road C |
        +---+----+
            |
            v
        +--------+
        | Road D |
        +---+----+
            |
            +-------> Road A
```

Emergency conditions can alter the normal sequence to provide priority to the requested road.

## 🧪 Simulation

The RTL design can be simulated using **Xilinx Vivado**.

Simulation verifies:

* Normal traffic signal sequence
* FSM state transitions
* Green/yellow/red timing
* Reset operation
* Emergency vehicle detection
* Emergency road priority
* Return to normal traffic operation

## ▶️ How to Run in Vivado

1. Open **Xilinx Vivado**.
2. Create a new RTL project.
3. Add `traffic_light_controller.v` as a Design Source.
4. Add `traffic_light_controller_tb.v` as a Simulation Source.
5. Select the appropriate top module.
6. Run **Simulation → Run Behavioral Simulation**.
7. Observe the traffic signal outputs in the waveform.

## 📊 Expected Behavior

### Normal Operation

```text
Road A: GREEN
Road B: RED
Road C: RED
Road D: RED

        ↓

Road A: YELLOW
Road B: RED
Road C: RED
Road D: RED

        ↓

Road A: RED
Road B: GREEN
Road C: RED
Road D: RED
```

The sequence continues for Roads C and D.

### Emergency Operation

If an emergency request is detected on a particular road, the controller prioritizes that road while maintaining safe traffic transitions.

## 🎯 Learning Outcomes

This project demonstrates practical knowledge of:

* Verilog HDL
* RTL Design
* Finite State Machines
* Sequential and combinational logic
* Counters and timing control
* Priority logic
* Traffic control systems
* RTL simulation and debugging
* Xilinx Vivado

## 🚀 Future Improvements

Possible enhancements include:

* Pedestrian crossing support
* Traffic-density sensors
* Multiple emergency priority levels
* Ambulance/fire-truck identification
* Adaptive traffic timing
* FPGA hardware implementation
* Seven-segment display for countdown timing
* UART-based traffic monitoring


