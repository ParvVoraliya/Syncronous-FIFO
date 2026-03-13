# FIFO Memory Design using Verilog

## Description
This project implements a **First-In-First-Out (FIFO) memory buffer using Verilog HDL**. FIFO is a commonly used digital design structure that stores data in the order it is received and outputs it in the same order.

The design allows data to be written into the FIFO using a **write signal (`wr`)** and read using a **read signal (`rd`)**. It also provides **status flags (`full` and `empty`)** to indicate whether the buffer can accept new data or provide stored data.

The FIFO size and data width are configurable using parameters.

---

## Module Interface

| Signal | Type | Description |
|------|------|-------------|
| `clk` | Input | System clock used to synchronize read and write operations |
| `rst` | Input | Reset signal used to initialize the FIFO |
| `wr` | Input | Write enable signal used to store data into the FIFO |
| `rd` | Input | Read enable signal used to read data from the FIFO |
| `din[DATA_WIDTH-1:0]` | Input | Input data to be written into the FIFO |
| `dout[DATA_WIDTH-1:0]` | Output | Data output from the FIFO |
| `empty` | Output | Indicates that the FIFO is empty |
| `full` | Output | Indicates that the FIFO is full |

---

## Parameters

| Parameter | Description |
|----------|-------------|
| `DATA_WIDTH` | Defines the number of bits in each data word |
| `DEPTH` | Defines the number of storage locations in the FIFO |

---

## Working Principle

The FIFO operates based on **two pointers:**

- **Write Pointer (wr_ptr)** → Points to the next location where data will be written.
- **Read Pointer (rd_ptr)** → Points to the next location from which data will be read.

### Write Operation
1. When the `wr` signal is HIGH and FIFO is not full, the input data `din` is stored in the memory.
2. The **write pointer increments** to the next location.

### Read Operation
1. When the `rd` signal is HIGH and FIFO is not empty, the stored data is output through `dout`.
2. The **read pointer increments** to the next location.

### Status Flags
- **Empty Flag**
  - Indicates the FIFO contains no data.
  - Occurs when read and write pointers are equal.

- **Full Flag**
  - Indicates the FIFO cannot accept more data.
  - Occurs when the write pointer reaches the maximum storage capacity.

---

## Features
- Parameterized FIFO design
- Configurable **data width**
- Configurable **FIFO depth**
- Supports **simultaneous read and write operations**
- Includes **full and empty status flags**

---

## Applications
- Data buffering
- Communication interfaces
- Streaming data systems
- Processor and peripheral communication
- FPGA and ASIC digital systems
