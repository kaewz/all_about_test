//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet.examples.wpan.all_about_test;

import inet.wpan.linklayer.ieee802154.Ieee802154csmaNic;
import inet.wpan.networklayer.Ieee802154StarRouting.Ieee802154StarRouting;

//import inet.underTest.wpan.battery.Ieee802154Battery;
import inet.battery.models.InetSimpleBattery;
//import inet.wpan.applications.Ieee802154TestApp.Ieee802154TestApp;
import inet.mobility.IMobility;
import inet.base.NotificationBoard;
import inet.wpan.Isabel.Base.Display;

//
// This module implements simple ZigBee nodes with IEEE 802.15.4 MAC and PHY layer, plus a simple test app layer
//

module testNode
{
    parameters:
        @node();
        string mobilityType;
        volatile double numHosts;
    gates:
        input radioIn;
    submodules:
        notificationBoard: NotificationBoard {
            parameters:
                @display("p=65,70;i=block/control");

        }
        mobility: <mobilityType> like IMobility {
            parameters:
                @display("p=65,150;i=block/cogwheel");

        }
        disp: Display {
            parameters:
                @display("p=65,230;i=block/app2");

        }
        // battery module
//        battery: InetSimpleBattery{
//            parameters:
//                @display("p=65,310;i=block/plug");
//
//        }
        // application-layer
        app: testApp {
            parameters:
                @display("p=250,100;i=block/source");

        }
        // network layer
//        net: Ieee802154StarRouting {
//            parameters:
//                @display("p=250,200;i=block/network2");
//
//        }
        // network interface
        nic: Ieee802154csmaNic {
            parameters:
                @display("p=250,300;q=queue;i=block/ifcard");

        }
    connections allowunconnected:
        radioIn --> nic.radioIn;
        nic.upperLayerOut --> app.lowerLayerIn;
        nic.upperLayerIn <-- app.lowerLayerOut;
//        net.upperLayerOut --> app.lowerLayerIn;
//        net.upperLayerIn <-- app.lowerLayerOut;
}
