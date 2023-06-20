using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WwiseUIEvents : MonoBehaviour
{

    // If the UI object is also a button, navigate to the Button interactable script secton
    // Create an event trigger for Pointer Enter and Pointer Exit.
    // Add a new event option under OnClick()
    // Add your audio gameObject containing this script. Set it to Runtime Only/Editor & Runtime based on your needs.
    // On the dropdown to the right of your object in the Button interactable script secton, go to your object name within the drop down. Select the OnClick() function.
    // This will now call the Wwise post event function 

    public void OnClick()
    {
        AkSoundEngine.PostEvent("UI_Click", gameObject);
    }


    // Add this script to an audio GameObject
    // Then, for the UI object you want to add audio for, go to the Event Trigger interactable script secton
    // Create an event trigger for Pointer Enter and Pointer Exit.
    // Add your audio gameObject containing this script. Set it to Runtime Only/Editor & Runtime based on your needs.
    // On the dropdown to the right of your object in the Event Trigger section, go to your object name within the drop down. Select the OnMouseOver() function.
    // This will now call the Wwise post event function 

       public void OnMouseOver()
   {
       AkSoundEngine.PostEvent("UI_Hover", gameObject);
   }

}
