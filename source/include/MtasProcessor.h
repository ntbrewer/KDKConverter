/** \file MtasProcessor.h
 *
 * Header file for MTAS analysis
 */

#ifndef __MTAS_PROCESSOR_H_
#define __MTAS_PROCESSOR_H_

#include "EventProcessor.h"
#include <vector>

class DetectorSummary;
class RawEvent;
class ChanEvent;
/**
 * \brief Handles detectors of type dssd_front and dssd_back
 */
class MtasProcessor : public EventProcessor 
{
	private:
		DetectorSummary *mtasSummary; ///< all detectors of type dssd_front
		DetectorSummary *siliSummary; 
		DetectorSummary *logiSummary;
		DetectorSummary *refmodSummary; //added by Goetz
		static bool isTapeMoveOn;
		static bool isMeasureOn;
    static bool isBkgOn;
    static bool isLightPulserOn;
    static bool isIrradOn;
    static unsigned cycleNumber;
    
    static double measureOnTime;
    double firstTime;

	public:
		MtasProcessor(); // no virtual c'tors
		virtual void DeclarePlots(void) const;
		virtual bool Process(RawEvent &event);
    
	private:
		struct MtasData //to trzeba przerobic
		{
			MtasData(ChanEvent *chan);
			
			std::string detSubtype;
			double energy;
			double calEnergy;
			double time;
			double location;

			std::vector<int> trace;
    		};
};

#endif // __MTAS_POCESSOR_H_
