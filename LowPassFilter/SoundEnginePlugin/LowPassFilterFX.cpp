/*******************************************************************************
The content of this file includes portions of the AUDIOKINETIC Wwise Technology
released in source code form as part of the SDK installer package.

Commercial License Usage

Licensees holding valid commercial licenses to the AUDIOKINETIC Wwise Technology
may use this file in accordance with the end user license agreement provided
with the software or, alternatively, in accordance with the terms contained in a
written agreement between you and Audiokinetic Inc.

Apache License Usage

Alternatively, this file may be used under the Apache License, Version 2.0 (the
"Apache License"); you may not use this file except in compliance with the
Apache License. You may obtain a copy of the Apache License at
http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed
under the Apache License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
OR CONDITIONS OF ANY KIND, either express or implied. See the Apache License for
the specific language governing permissions and limitations under the License.

  Copyright (c) 2021 Audiokinetic Inc.
*******************************************************************************/

#include "LowPassFilterFX.h"
#include "../LowPassFilterConfig.h"

#include <AK/AkWwiseSDKVersion.h>

AK::IAkPlugin* CreateLowPassFilterFX(AK::IAkPluginMemAlloc* in_pAllocator)
{
    return AK_PLUGIN_NEW(in_pAllocator, LowPassFilterFX());
}

AK::IAkPluginParam* CreateLowPassFilterFXParams(AK::IAkPluginMemAlloc* in_pAllocator)
{
    return AK_PLUGIN_NEW(in_pAllocator, LowPassFilterFXParams());
}

AK_IMPLEMENT_PLUGIN_FACTORY(LowPassFilterFX, AkPluginTypeEffect, LowPassFilterConfig::CompanyID, LowPassFilterConfig::PluginID)

LowPassFilterFX::LowPassFilterFX()
    : m_pParams(nullptr)
    , m_pAllocator(nullptr)
    , m_pContext(nullptr)
{
}

LowPassFilterFX::~LowPassFilterFX()
{
}

AKRESULT LowPassFilterFX::Init(AK::IAkPluginMemAlloc* in_pAllocator, AK::IAkEffectPluginContext* in_pContext, AK::IAkPluginParam* in_pParams, AkAudioFormat& in_rFormat)
{
    m_pParams = (LowPassFilterFXParams*)in_pParams;
    m_pAllocator = in_pAllocator;
    m_pContext = in_pContext;
    so_lpf.resize(in_rFormat.GetNumChannels());

    for (auto& filterChannel : so_lpf)
    {
        filterChannel.Setup(in_rFormat.uSampleRate);
    }

    return AK_Success;
}

AKRESULT LowPassFilterFX::Term(AK::IAkPluginMemAlloc* in_pAllocator)
{
    AK_PLUGIN_DELETE(in_pAllocator, this);
    return AK_Success;
}

AKRESULT LowPassFilterFX::Reset()
{
    return AK_Success;
}

AKRESULT LowPassFilterFX::GetPluginInfo(AkPluginInfo& out_rPluginInfo)
{
    out_rPluginInfo.eType = AkPluginTypeEffect;
    out_rPluginInfo.bIsInPlace = true;
	out_rPluginInfo.bCanProcessObjects = false;
    out_rPluginInfo.uBuildVersion = AK_WWISESDK_VERSION_COMBINED;
    return AK_Success;
}

void LowPassFilterFX::Execute(AkAudioBuffer* io_pBuffer)
{

    if (m_pParams->m_paramChangeHandler.HasChanged(PARAM_FREQUENCY_ID))
    {
        for (auto& filterChannel : so_lpf) 
            {
            filterChannel.SetFrequency(m_pParams->RTPC.fFrequency);
            }
    }
    const AkUInt32 uNumChannels = io_pBuffer->NumChannels();

    AkUInt16 uFramesProcessed;
    for (AkUInt32 i = 0; i < uNumChannels; ++i)
    {
        AkReal32* AK_RESTRICT pBuf = (AkReal32* AK_RESTRICT)io_pBuffer->GetChannel(i);

        so_lpf[i].Execute(pBuf, io_pBuffer->uValidFrames);
        
    }
}

AKRESULT LowPassFilterFX::TimeSkip(AkUInt32 in_uFrames)
{
    return AK_DataReady;
}
