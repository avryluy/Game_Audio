#include "SecondOrderLPF.h"
#include <cmath>

SecondOrderLPF::SecondOrderLPF()
	// initialize variables
	: m_sampleRate(0)
	, m_frequency(0.0f)
	, a0(1.0f)
	, a1(0.0f)
	, a2(0.0f)
	, b0(0.0f)
	, b1(0.0f)
	, b2(0.0f)
	, Q(0.707f)
	, alpha(0.0f)
	, w0(0.0f)
	, m_b0(0.0f)
	, m_b1(0.0f)
	, m_b2(0.0f)
	, m_a1(0.0f)
	, m_a2(0.0f)
	, m_x1(0.0f)
	, m_x2(0.0f)
	, m_y1(0.0f)
	, m_y2(0.0f)
	, m_previousOutput(0.0f)
	, m_frequencyChanged(false)
{
}

SecondOrderLPF::~SecondOrderLPF(){}

void SecondOrderLPF::Setup(AkUInt32 in_sampleRate)
{
	// stores sample rate and initializes modified in/out values to 0
	m_sampleRate = in_sampleRate;
	m_x1 = m_x2 = m_y1 = m_y2 = 0;
}

void SecondOrderLPF::SetFrequency(AkReal32 in_newFrequency)
{
	if (m_sampleRate > 0)
	{
		//Store frequency if we have a sample rate and change bool to true
		m_frequency = in_newFrequency;
		m_frequencyChanged = true;
	}
}

void SecondOrderLPF::calcCoeffs()
{
	// calculate the coefficients
	// Direct transform II filters use 6 coefficients to help deal with delay and feedback
	w0 = 2 * M_PI * m_frequency / m_sampleRate;
	alpha = sin(w0) / (2 * Q);

	b0 = (1 - cos(w0)) / 2;
	b1 = 1 - cos(w0);
	b2 = (1 - cos(w0)) / 2;
	a0 = 1 + alpha;
	a1 = -2 * cos(w0);
	a2 = 1 - alpha;

	//Normalize
	//Why normalize? Normalizing by the coeff impacted by the Q seems to assist in frequency response and reducing feedback at lower Hz

	m_b0 = b0 / a0;
	m_b1 = b1 / a0;
	m_b2 = b2 / a0;
	m_a1 = a1 / a0;
	m_a2 = a2 / a0;
	
	
}


void SecondOrderLPF::Execute(AkReal32* io_pBuffer, AkUInt16 in_uValidFrames)
{
	AkReal64 a0 = 1.0f, 
	a1 = a2 = b1 = b2 = 0.0f,
	Q = 0.707f;
		
	if (m_frequencyChanged)
	{
		//re-calc coefficients based on frequency changes
		calcCoeffs();
		m_frequencyChanged = false;
	}

	// Create frame processed var
	AkUInt16 uFramesProcessed = 0;

	while (uFramesProcessed < in_uValidFrames)
	{
		// Filtering code
		// y(n) = a0*x(n) + a1*x(n-1) + a2*x(n-2) - b*y(n-1) + b2*y(n-2)
		// using m_coeff variables to account for filtering in a loop; we store the results as we iterate and it results in a more accurate filter
		m_previousOutput = io_pBuffer[uFramesProcessed] =
				m_b0 * io_pBuffer[uFramesProcessed] + m_b1 * m_x1 + m_b2 * m_x2 - m_a1 * m_y1 - m_a2 * m_y2;

		// Stores modified values as execute iterates over frames
		m_x2 = m_x1;
		m_x1 = io_pBuffer[uFramesProcessed];
		m_y2 = m_y1;
		m_y1 = m_previousOutput;
		++uFramesProcessed; //PRE-Incremental iteration
	}
}