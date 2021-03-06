//
//        Copyright (C) 1999, 2000, HIMSS, RSNA and Washington University
//
//        The MESA test tools software and supporting documentation were
//        developed for the Integrating the Healthcare Enterprise (IHE)
//        initiative Year 1 (1999-2000), under the sponsorship of the
//        Healthcare Information and Management Systems Society (HIMSS)
//        and the Radiological Society of North America (RSNA) by:
//                Electronic Radiology Laboratory
//                Mallinckrodt Institute of Radiology
//                Washington University School of Medicine
//                510 S. Kingshighway Blvd.
//                St. Louis, MO 63110
//        
//        THIS SOFTWARE IS MADE AVAILABLE, AS IS, AND NEITHER HIMSS, RSNA NOR
//        WASHINGTON UNIVERSITY MAKE ANY WARRANTY ABOUT THE SOFTWARE, ITS
//        PERFORMANCE, ITS MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR
//        USE, FREEDOM FROM ANY DEFECTS OR COMPUTER DISEASES OR ITS CONFORMITY 
//        TO ANY SPECIFICATION. THE ENTIRE RISK AS TO QUALITY AND PERFORMANCE OF
//        THE SOFTWARE IS WITH THE USER.
//
//        Copyright of the software and supporting documentation is
//        jointly owned by HIMSS, RSNA and Washington University, and free
//        access is hereby granted as a license to use this software, copy
//        this software and prepare derivative works based upon this software.
//        However, any distribution of this software source code or supporting
//        documentation or derivative works (source code and supporting
//        documentation) must include the three paragraphs of this copyright
//        notice.

// $Id: MHL7Factory.hpp,v 1.16 2006/06/29 16:08:32 bhasselfeld Exp $ $Author: bhasselfeld $ $Revision: 1.16 $ $Date: 2006/06/29 16:08:32 $ $State: Exp $
//
// ====================
//  = FILENAME
//	MHL7Factory.hpp
//
//  = AUTHOR
//	Steve Moore
//
//  = COPYRIGHT
//	Copyright HIMSS, RSNA, Washington University: 1999, 2000
//
// ====================
//
//  = VERSION
//	$Revision: 1.16 $
//
//  = DATE RELEASED
//	$Date: 2006/06/29 16:08:32 $
//
//  = COMMENTS
//

#ifndef MHL7FactoryISIN
#define MHL7FactoryISIN

#include <iostream>
#include <string>

#include "hl7_api.h"

using namespace std;

class MHL7Msg;
class MString;

class MHL7Factory
// = TITLE
///	A factory class for HL7 messages.
//
// = DESCRIPTION
/**	This class is used to produce MHL7Msg objects using
	different types of inputs (files, buffers). */
{
public:
  // = The standard methods in this framework.

  MHL7Factory();
  ///< Default constructor

  MHL7Factory(const MHL7Factory& cpy);

  virtual ~MHL7Factory();

  virtual void printOn(ostream& s) const;
  /**<\brief This method is used in conjunction with the streaming operator <<
   to print the current state of MHL7Factory. */

  virtual void streamIn(istream& s);
  /**<\brief This method is used in conjunction with the streaming operator <<
   to print the current state of MHL7Factory. */
  
  // = Class specific methods.

  MHL7Factory(const MString& tablePath, const MString& version);
  /**<\brief In this constructor, tablePath defines the path to the files
   which define the supported HL7 messages.
   version is the file extension defining the version of messages
   to support.  More than one version can be supported in the
   tablePath directory. */

  virtual MHL7Msg* produce(const char* hl7Stream, int length=0);
  ///< Produce an HL7 Message from a stream of properly formatted text.

  virtual MHL7Msg* produce();
  ///< Produce an empty HL7 Message.

  virtual MHL7Msg* readFromFile(const MString& fileName);
  ///< Read an HL7 Message from a file.

  virtual MHL7Msg* produceACK(MHL7Msg& msg, const MString& prefix = "",
	const MString& ackCode = "", const MString& errorCondition = "");
  ///< Produce an ACK message using parameters from the input msg.

  virtual MHL7Msg* produceORR(MHL7Msg& msg, const MString& orderControl="",
	const MString& placerOrderNumber = "");
  ///< Produce an ORR message using parameters from the input ormMsg.

  virtual MHL7Msg* produceRSP(MHL7Msg& msg, const MString& prefix = "");
  ///< Produce an RSP message using parameters from the input msg.

  virtual MHL7Msg* produceRSPK22Baseline(MHL7Msg& msg, const MString& prefix = "");
  ///< Produce an RSP^K22 message using parameters from the input msg.

  virtual int appendRSPK22PatientIdentification(MHL7Msg& msg, MStringMap& m);
  ///< Appends PID, PD1 segments to RSP^K22 response

  virtual int appendContinuationText(MHL7Msg& msg, const MString& txt);
  ///< Appends a continuation pointer to the existing HL7 message.
 
  virtual MHL7Msg* produceOnlyMSH(const MString& fileName,
	  const MString& messageType);
  /**<\brief Produce an HL7 message that only contains an MSH segment.
   This message can then be filled in by someone else.
   fileName is an ASCII file that describes the MSH.
   messageType is the value in MSH.9 (Message Type). */

private:

  typedef struct {
    char* sourceSegment;
    int   sourceField;
    char* targetSegment;
    int   targetField;
  } HL7_COPY_MAP;

  int copyFields(HL7_COPY_MAP* copyMap, MHL7Msg& source, HL7MSG* target);
  int copyFields(MHL7Msg& source, HL7MSG* target);
  // Copy fields from the source HL7 message to the target message.

  HL7FLVR *mFlavor;
};

inline ostream& operator<< (ostream& s, const MHL7Factory& c) {
	  c.printOn(s);
	  return s;
};

inline istream& operator >> (istream& s, MHL7Factory& c) {
  c.streamIn(s);
  return s;
};

#endif
