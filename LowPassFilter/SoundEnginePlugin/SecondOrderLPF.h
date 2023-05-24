#pragma once

#include <AK/SoundEngine/Common/AkCommonDefs.h>
#include <cmath>
#include <complex>
#include <functional>

#define COEFF_SIZE_DOUBLE
#ifndef M_PI
#define M_PI 3.14159265359
#endif // !M_PI

class SecondOrderLPF
{
public:
	SecondOrderLPF();
	~SecondOrderLPF();

	// sets up data for filter
	void Setup(AkUInt32 in_sampleRate);
	//To be used with plug-in slider
	void SetFrequency(AkReal32 in_newFrequency);
	// actual filter processing
	void Execute(AkReal32* io_pBuffer, AkUInt16 in_uValidFrames);

private:

	// Keep coefficient calculations prive. Not a needed public function.
	void calcCoeffs(void);

	//Make space for variables needed in memory
	AkUInt64 m_sampleRate;
	AkReal64 m_frequency;
	// coefficient determinants by sample rate and frequency
    AkReal64 w0;
    AkReal64 alpha;
	// coefficients
	AkReal64 a0;
	AkReal64 a1;
	AkReal64 a2;
    AkReal64 b0;
	AkReal64 b1;
	AkReal64 b2;
	AkReal64 Q; //set Q
    AkReal64 m_b0, m_b1, m_b2, m_a1, m_a2; // normalized coefficients by a0
    AkReal64 m_x1, m_x2, m_y1, m_y2; //modified in and out samples
	AkReal64 m_previousOutput;
	bool m_frequencyChanged;

};