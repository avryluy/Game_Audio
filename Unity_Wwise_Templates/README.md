# Unity_Wwise_Templates README
This is a folder of Wwise script templates to be used with Unity Engine. All of them are just starting points to get Wwise audio posting within Unity for either the player character or UI.

## Available Templates
### PlayerCharacterAudio_TEMP
This script allows you to post basic actions like attack, damaged, death, and footsteps. *Note:* footstep triggers here leverage animation events for calling and collider objects with AkSwitch scripts to manage Switch groups.

### ThirdPersonListener
This script changes the audio positioning to be reliant on the third person camera movements, rather than the z-axis orientation of the player character gameObject.

### VolumeRTPCSliders
This script allows for basic management of Wwise busses via the audio control menu.

### WwiseUIEvents
This script helps manage audio posting for standard UI events, like mouse clicks and mouse hover on/off.

## Getting Started
### Downloading & Installing

1. Download the raw source code since these are just template scripts.
2. Open your Unity project and add them to a unqiuely named folder. I.E. "Template Scripts"
3. Copy the scripts into the folder named in step 2.
4. Attach template scripts to revelant gameobjects.
5. Rename variables in script as needed.
6. Name Wwise variables related to scripts so they get called upon correctly.
7. Build Soundbanks and test in engine.

### Requirements
- Wwise x64 2019 or above
- Unity 2019 or above
- Windows 10 or above

