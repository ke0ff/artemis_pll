# artemis_pll
LMX2594 PLL Synth Project Files (4 GHz to 15 GHz)

Artemis PLL Synthesizer application

The follow-on to the Orion synthesizer.  Artemis uses an LMX2594 (TI) PLL (with integrated VCO) and an ATtiny-3217 to configure the PLL via a SPI interface. Uses a 5-bit channel select logic interface to set a channel (32 max channels, but likely just a handful will be implemented) or can accept serial commands (115200 baud) to set channel using a serial command line format. Currently requires channel data to be previously determined using the TI application software (TICS Pro) and compiled using the Microchip/Atmel code development environment.
Note: While the TI LMX2594 covers 10MHz to 15 GHz, the choice of buffer amplifier limits the available output range to 4 GHz and above.  For applications needing less than 4GHz, use the Orion-I synthesizer.  For applications needing full coverage, a different amplifier design (i.e., a different PCB layout) would be needed.

Atemis3217.zip holds the initial software commit.
Artemis Source holds in-process commits.

To Build the SW project, first unzip "Artemis3217.zip".  Next, copy files (if any) from "Artemis Source" to their respective locations inside the Atmel project folder structure (this might require some trial and error to find where the files belong).
Lastly, build the project and program the target device.

These supporting files are also included:</br>
ArtemisHW.zip holds the CircuitStudio schematic and PCB files</br>
Artemis_schem.pdf is the schematic in pdf format</br>
Artemis_BOM.xlsx is the Bill Of Materials</br>
