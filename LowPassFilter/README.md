# LowPassFilter README
This is a second order low pass filter plug-in designed for use with Wwise. There are two RTPC-enabled parameters to this plug-in:
1. **Filter Cutoff Frequency:** Sets the cutoff frequency for the lowpass filter.
2. **Output Gain:** Cuts or boosts output signal post-processing of the filter. Max limit of 12dB gain.

## Getting Started
### Downloading & Installing

1. Grab the latest version from [Releases](https://github.com/avryluy/Game_Audio_Scripts/releases).
2. Open the Audiokinetic Launcher.
3. Navigate to the plugins tab.
4. Scroll down to the **Install New Plug-Ins** section
5. Select the arrow next to "Add from Directory..." and select "**Add from archive...**"
6. Select LowPassFilter_v2021.1.9.7847.zip.
7. Select **Open**.
8. Follow the Audiokinetic Launcher installation options.

### Using plug-in in Wwise
1. Open up a project in Wwise 2021
2. Navigate to an SFX Object, Actor-Mixer, Bus, or Container.
3. Select the Effects tab in the Property Editor window.
4. Click the double arrows on the left hand side (>>). Select "Second Order LPF" from the drop-down list.
5. Click the Edit (...) button in the Property Editor window. You can now set your cutoff frequency and output gain.

#### **Reminder!** Both parameters are RTPC Enabled.
  1. In the floating plug-in window, select the RTPC tab.
  2. You can add LFOs, Game Parameters, etc. here to manipulate the plug-in via RTPC


### Requirements
- Wwise x64 2021.1.9.7487
- Windows 10 or above

