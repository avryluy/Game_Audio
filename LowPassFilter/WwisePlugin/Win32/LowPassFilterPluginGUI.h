#pragma once

#include "../LowPassFilterPlugin.h"

class LowPassFilterPluginGUI final
	: public AK::Wwise::Plugin::PluginMFCWindows<>
	, public AK::Wwise::Plugin::GUIWindows
{
public:
	LowPassFilterPluginGUI();

};
