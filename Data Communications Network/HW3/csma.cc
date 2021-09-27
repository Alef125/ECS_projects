/* -*- Mode:C++; c-file-style:"gnu"; indent-tabs-mode:nil; -*- */
/*-------------------- Ali Fathi 94109205 --------------------*/

#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/csma-module.h"
#include "ns3/internet-module.h"
#include "ns3/applications-module.h"
#include "ns3/ipv4-global-routing-helper.h"
#include "ns3/animation-interface.h"
#include "ns3/flow-monitor-helper.h"

// Network Topology
//
//  n1   n2   n3   n4   n5   n6   n7   n8
//   |    |    |    |    |    |    |    |
//   ====================================
//             LAN 19.20.5.0


using namespace ns3;

NS_LOG_COMPONENT_DEFINE ("HW3_94109205");

int 
main (int argc, char *argv[])
{
  uint32_t nCsma = 8;

  uint32_t modeNumber = 1;
    
  CommandLine cmd;
  cmd.AddValue ("modeNumber", "Mode for Application Layer Traffic Generation Rate, 1<= =<7", modeNumber);
  cmd.Parse (argc,argv);

  UintegerValue maxPackets = UintegerValue (2000);
    TimeValue allIntervals[7] = {TimeValue (Seconds (0.31496)), TimeValue (Seconds (0.2216)),
                  TimeValue (Seconds (0.123077)), TimeValue (Seconds (0.06206)),
                  TimeValue (Seconds (0.030166)), TimeValue (Seconds (0.01556)),
        TimeValue (Seconds (0.007809))};
  // [Traffic, Interval] = [25.4Kbps, 314.96ms], [36.1Kbps, 221.6ms], [65.0Kbps, 123.077ms],
  //          [128.9Kbps, 62.06ms], [265.2Kbps, 30.166ms], [514.0Kbps, 15.56ms], [1024.5Kbps, 7.809ms]
  TimeValue interval = allIntervals[modeNumber-1];
  Time endTime = Seconds (15.0);
    
  LogComponentEnable ("UdpEchoClientApplication", LOG_LEVEL_INFO);
  LogComponentEnable ("UdpEchoServerApplication", LOG_LEVEL_INFO);

  NodeContainer csmaNodes;
  csmaNodes.Create (nCsma);

  CsmaHelper csma;
  csma.SetChannelAttribute ("DataRate", StringValue ("1024Kbps"));
  csma.SetChannelAttribute ("Delay", StringValue ("2ms"));

  NetDeviceContainer csmaDevices;
  csmaDevices = csma.Install (csmaNodes);

  InternetStackHelper stack;
  stack.Install (csmaNodes);

  Ipv4AddressHelper address;
  address.SetBase ("19.20.5.0", "255.255.255.0");
  Ipv4InterfaceContainer csmaInterfaces;
  csmaInterfaces = address.Assign (csmaDevices);

  UdpEchoServerHelper echoServer5 (9);
  UdpEchoServerHelper echoServer6 (9);
  UdpEchoServerHelper echoServer3 (9);
  UdpEchoServerHelper echoServer4 (9);

  ApplicationContainer serverApps5 = echoServer5.Install (csmaNodes.Get (4));
  serverApps5.Start (Seconds (1.0));
  serverApps5.Stop (endTime);
    
  ApplicationContainer serverApps6 = echoServer6.Install (csmaNodes.Get (5));
  serverApps6.Start (Seconds (1.0));
  serverApps6.Stop (endTime);
    
  ApplicationContainer serverApps3 = echoServer3.Install (csmaNodes.Get (2));
  serverApps3.Start (Seconds (1.0));
  serverApps3.Stop (endTime);
    
  ApplicationContainer serverApps4 = echoServer4.Install (csmaNodes.Get (3));
  serverApps4.Start (Seconds (1.0));
  serverApps4.Stop (endTime);

  UdpEchoClientHelper echoClient1 (csmaInterfaces.GetAddress (4), 9);
  echoClient1.SetAttribute ("MaxPackets", maxPackets);
  echoClient1.SetAttribute ("Interval", interval);
  echoClient1.SetAttribute ("PacketSize", UintegerValue (1024));
  
  UdpEchoClientHelper echoClient2 (csmaInterfaces.GetAddress (5), 9);
  echoClient2.SetAttribute ("MaxPackets", maxPackets);
  echoClient2.SetAttribute ("Interval", interval);
  echoClient2.SetAttribute ("PacketSize", UintegerValue (1024));
  
  UdpEchoClientHelper echoClient7 (csmaInterfaces.GetAddress (2), 9);
  echoClient7.SetAttribute ("MaxPackets", maxPackets);
  echoClient7.SetAttribute ("Interval", interval);
  echoClient7.SetAttribute ("PacketSize", UintegerValue (1024));
    
  UdpEchoClientHelper echoClient8 (csmaInterfaces.GetAddress (3), 9);
  echoClient8.SetAttribute ("MaxPackets", maxPackets);
  echoClient8.SetAttribute ("Interval", interval);
  echoClient8.SetAttribute ("PacketSize", UintegerValue (1024));

  ApplicationContainer clientApps1 = echoClient1.Install (csmaNodes.Get (0));
  clientApps1.Start (Seconds (2.0));
  clientApps1.Stop (endTime);
    
  ApplicationContainer clientApps2 = echoClient2.Install (csmaNodes.Get (1));
  clientApps2.Start (Seconds (2.0));
  clientApps2.Stop (endTime);
    
  ApplicationContainer clientApps7 = echoClient7.Install (csmaNodes.Get (6));
  clientApps7.Start (Seconds (2.0));
  clientApps7.Stop (endTime);
    
  ApplicationContainer clientApps8 = echoClient8.Install (csmaNodes.Get (7));
  clientApps8.Start (Seconds (2.0));
  clientApps8.Stop (endTime);

  Ipv4GlobalRoutingHelper::PopulateRoutingTables ();

  std::string modeStr;
  modeStr = std::to_string(modeNumber);
  std::string fileName = "HW3/HW3_94109205_Mode_" + modeStr;
  csma.EnablePcapAll (fileName);
  
  AsciiTraceHelper asciiTraceHelper;
  Ptr<OutputStreamWrapper> stream = asciiTraceHelper.CreateFileStream(fileName+".tr");
  csma.EnableAsciiAll(stream);
    
  AnimationInterface animationInterface(fileName+".xml");
  animationInterface.SetConstantPosition (csmaNodes.Get (0), 50, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (1), 100, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (2), 150, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (3), 200, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (4), 250, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (5), 300, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (6), 350, 200);
  animationInterface.SetConstantPosition (csmaNodes.Get (7), 400, 200);
  animationInterface.EnableIpv4RouteTracking(fileName+".xml",
                                              Time (Seconds (1.0)),
                                              Time (endTime),
                                              Time (Seconds (5.0)));
    
  // Flow monitor
  Ptr<FlowMonitor> flowMonitor;
  FlowMonitorHelper flowHelper;
  flowMonitor = flowHelper.InstallAll();
    
  Simulator::Stop (endTime);
  Simulator::Run ();
    
  flowMonitor->SerializeToXmlFile(fileName+"_flow.xml", true, true);

  return 0;
}
