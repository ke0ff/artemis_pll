# artemis_pll
LMX2594 PLL Synth Project Files (10 MHz to 15 GHz)

Artemis PLL Synthesizer application

The follow-on to the Orion synthesizer.  Artemis uses an LMX2594 (TI) PLL (with integrated VCO) and an ATtiny-3217 to configure the PLL via a SPI interface. Uses a 5-bit channel select logic interface to set a channel (32 max channels, but likely just a handful will be implemented) or can accept serial commands (115200 baud) to set channel using a serial command line format. Requires channel data to be previously determined using the TI application software (TICS Pro).
