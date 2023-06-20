using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class VolumeRTPCSliders : MonoBehaviour
{

    public Slider thisSlider;
    public float masterVolume;
    public float SFXVolume;

  
  
    public void SetSpecificVolume(string whatValue)
    {
        float sliderValue = thisSlider.value;
        if (whatValue == "MasterVolume")
        {
            masterVolume = thisSlider.value;
            //RTPC name = Master_Volume
            AkSoundEngine.SetRTPCValue("Master_Volume", masterVolume);
        }
        if (whatValue == "SFX")
        {
            SFXVolume = thisSlider.value;
            //RTPC name = SFX_Volume
            AkSoundEngine.SetRTPCValue("SFX_Volume", SFXVolume);
        }
        
    }
}

