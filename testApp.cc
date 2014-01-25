#include "testApp.h"

Define_Module(testApp);

void testApp::initialize(int aStage)
{
    TrafGenPar::Initialize(astage);
    EV << getParentModule()->getFullName() << ": initializing Ieee802154TestApp, stage=" << aStage << endl;
        if (0 == aStage)
        {
            m_debug             = par("debug");
            mLowerLayerIn        = findGate("lowerLayerIn");
            mLowerLayerOut       = findGate("lowerLayerOut");
            m_moduleName        = getParentModule()->getFullName();
//            sumE2EDelay         = 0;
            numReceived         = 0;
            mNumTrafficMsgs     = 0;
            totalByteRcvd           = 0;
//            e2eDelayVec.setName("End-to-end delay");
//            meanE2EDelayVec.setName("Mean end-to-end delay");
        }
}

void testApp::finish()
{

}

void testApp::handleLowerMsg(cMessage* apMsg)
{
    broadcast* tmpPkt = check_and_cast<broadcast *>(apMsg);
    totalByteRcvd += tmpPkt->getByteLength();
    numRcvd++;
    EV << "[APP]: a message sent by " << tmpPkt->getSourceName() << " arrived at application";
    delete apMsg;
}

void testApp::handleSelfMsg(cMessage *apMsg)
{
    TrafGenPar::handleSelfMsg(apMsg);
}

void testApp::SendTraf(cPacket* apMsg,const char* apDest)
{
    delete apMsg;

    broadcast* appPkt = new broadcast("AppPkt");

    appPkt->setBitLength(PacketSize()*8);
    appPkt->setSourceName(m_moduleName);
    appPkt->setGenTime(simTime());

    mNumTrafficMsgs++;
    send(appPkt, mLowerLayerOut);
}
