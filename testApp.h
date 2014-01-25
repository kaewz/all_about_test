#ifndef TEST_APP
#define TEST_APP

#include "TrafGenPar.h"
#include "broadcast_m.h"

class testApp : public TrafGenPar
{
public:

    virtual void initialize(int);
    virtual void finish();

protected:
        virtual void handleSelfMsg(cMessage*);
        virtual void handleLowerMsg(cMessage*);
        virtual void SendTraf(cPacket *msg, const char*);

private:
        bool    m_debug;
        int     mLowerLayerIn;
        int     mLowerLayerOut;

        int     mCurrentTrafficPattern;

        double  mNumTrafficMsgs;
        double  mNumTrafficMsgRcvd;

        const char* m_moduleName;
        double  numRcvd;
        double  totalByteRcvd;

};

