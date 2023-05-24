
#include "LowPassFilterPluginGUI.h"

LowPassFilterPluginGUI::LowPassFilterPluginGUI()
{
}

ADD_AUDIOPLUGIN_CLASS_TO_CONTAINER(
    LowPassFilter,            // Name of the plug-in container for this shared library
    LowPassFilterPluginGUI,   // Authoring plug-in class to add to the plug-in container
    LowPassFilterFX           // Corresponding Sound Engine plug-in class
);
