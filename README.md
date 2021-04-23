# Scan-EventID-Powershell-Scripts
Scan EventID Powershell Scripts
# If the Remote host is a server host, you need to make sure that he Accessing Remote Computer’s Event Viewer is enabled 
# Method 1: Ensure your RPC services are running properly
“The RPC server is unavailable” problem can be caused by improper functioning of RPC service on every computers connected. You may follow the steps below to ensure that all the services related to RPC run normally.
1) Press the Windows logo key and R on your keyboard to open the Run dialog. Then type “services.msc” and press Enter.
2) On the Services window, scroll down to find the items DCOM Server Process Launcher, Remote Procedure Call (RPC) and RPC Endpoint Mapper. Ensure their status is Running and their startup is set to Automatic. 

# Method 2: Check the firewall on your computer
Firewalls can block traffic requested by RPC and therefore cause RPC server unavailable problem. You should check your firewall configuration and see if it blocks the network connections for RPC. If you are using a third-party firewall, read its instruction or do some research about it to unblock the RPC network connections. 

If you are using Windows Firewall, here are the steps of its configuration:

1) Press the Windows logo key and R on your keyboard to open the Run dialog. Then type “control“ and press Enter. 
2) On Control Panel, search windows firewall. And then click Allow an app through Windows Firewall below Windows Firewall.
3) Scroll down to find Remote Assistance. Ensure its communication is enabled (All the boxes of this item are ticked).

# Method 3: Check your network connection
“The RPC server is unavailable” problem sometimes occurs because your network connection is not set properly. To check your network connection:

1) Press the Windows logo key and R on your keyboard to open the Run dialog. Then type “ncpa.cpl” and press Enter. 
2) Right click the network connection you are using, and then select Properties.
3) Make sure File and Printer Sharing for Microsoft Networks and Internet Protocol Version 6 (TCP/IPv6) are enabled (The boxes next to these items are ticked).
