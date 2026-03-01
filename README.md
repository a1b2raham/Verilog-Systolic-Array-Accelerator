<b><h1> Systolic Array Matrix Multiplier</b></h1>

<center>This project is a Hardware-Accelerated Systolic Array Matrix Multiplier designed in Verilog.
It is a domain-specific architecture (DSA) optimized for high-throughput matrix operations, similar to the technology found in 
Google’s Tensor Processing Units (TPUs) and modern AI accelerators.</center>

<b><h2>Verification</h2></b>
<b>64*64</b> matrix multiplication
[Command launch_simulation.txt](https://github.com/user-attachments/files/25659222/Command.launch_simulation.txt)

<b><h2>Block Diagram</b></h2>
<img width="245" height="206" alt="image" src="https://github.com/user-attachments/assets/8d2189fe-85ec-4c3d-a60b-7994017f43a8" />


<b><h2>Key Features</b></h2>

1.<b>Fully Parameterized Design</b>: Easily adjust Matrix Dimension (D) and Data Bit-Width (W) via top-level parameters (top.v)<br>

2.<b>Arithmetic Precision</b>: Built-in bit-growth management (W*2 + 1 accumulator) to prevent overflow during large-scale accumulations.<br>

3.<b>Advanced Data Mapping</b>: Features a "Flattened Port" strategy to bypass standard Verilog array limitations, making the core 100% compatible with Vivado, Quartus, and ISE synthesis tools.


<b><h2>Technical Specifications</b></h2>

1.<b> Pipeline Latency</b>: The accelerator follows a deterministic timing model. The total clock cycles (T) required from the first input to the final stable result is:
<b><center>T = 3D - 2</center></b>
(For a 20x20 matrix, the full result is ready in exactly 58 cycles).

2.<b>The Processing Element (PE)</b>: Each PE contains a high-speed multiplier and an accumulator. It passes its inputs to its neighbors (East and South) on every clock cycle, ensuring constant data movement.

<b><h2>Project Structure</b></h2>
1. <b>unit.v</b> : The Processing Element (PE) logic.
2. <b>PISO.v</b> : Parallel-In Serial-Out data feeder with customizable data width.
3. <b>top.v</b>: The top-level grid generator using Verilog generate blocks.
4. <b>test.v</b>: The top-level grid generator using Verilog generate blocks.

<b><h2>How to Simulate</h2></b>
1. Open Vivado 2020.1 (or later).
2. Add the .v files to a new project.
3. Set test.v as the top module for simulation.
4. Run Behavioral Simulation.
  <b>Note</b>: For larger matrices (e.g., 16x16), ensure your simulation runtime is set to all or at least 5000ns to account for pipeline latency.


<b><h3>Linkedin</h3></b>: www.linkedin.com/in/abraham-santhosh-a1551a328
  
