# Digesting system command outputs with Python & Google's Open Sourced TextFSM

## Verify
Verify script as Open Sourced (or with script [check-md5.sh](check-md5.sh)):
1. `md5 FILE > FILE.check`
1. `cmp FILE.md5 FILE.check` 
1. `echo $?` # if 0 it is OK, otherwise it is not with output such as "FILE.md5 FILE.check differ: char 23, line 1"

## Files
* [digest-data.py](digest-data.py)

## Directories
* Source data directory
* [Template directory](templates)
* (Digestion output directory)

## Perform
1. Ensure command output files are in a directory (such as default "data"), and there is a matching template (such as in default "templates")
1. Setup and activate the Python virtualenv (first time also run `pip install textfsm`)
1. Run the digestion script (HEADER=1 will print the column attribute names on the first line)
   * Syntax: <strong>python digest-data.py inputfilename templatefilename > outputfilename</strong>
   ```
   (sysdata) $ HEADER=1 python digest-data.py data/ibm-aix-lparstat-i.txt templates/ibm-aix-lparstat-i.textfsm
   ['Node_Name', 'Partition_Name', 'Partition_Number', 'Type', 'Mode', 'Entitled_Capacity', 'Shared_Pool_ID', 'Variable_Capacity_Weight', 'Online_Virtual_CPUs', 'Online_Memory', 'Desired_Capacity', 'Desired_Virtual_CPUs', 'Desired_Memory', 'Maximum_Memory', 'Memory_Mode', 'Power_Saving_Mode']
   ['VIOS8127', '780-4-VIO1', '2', 'Shared-SMT-4', 'Uncapped', '2.00', '0', '200', '4', '8192', '2.00', '4', '8192', '16384', 'Dedicated', 'Disabled']
   ['VIOS8128', '780-4-VIO2', '2', 'Shared-SMT-4', 'Uncapped', '2.00', '0', '200', '4', '8192', '2.00', '4', '8192', '16384', 'Dedicated', 'Disabled']

   (sysdata) $ HEADER=1 python digest-data.py data/ibm-aix-entstat.txt templates/ibm-aix-entstat.textfsm
   (sysdata) code/unix/aix/sysdata $ python digest-data.py data/ibm-aix-fcstat.txt templates/ibm-aix-fcstat.textfsm
   ['fcs0', '0x20000120FA55E0EC', '0x10000090FA55E0EC', '8 GBIT', '8 GBIT', '0x0BDD80', 'Link Up', '0', '38', '0', '471232996864', '1008067399936']
   ['fcs1', '0x20000120FA55E0ED', '0x10000090FA55E0ED', '8 GBIT', '8 GBIT', '0x0BDC80', 'Link Up', '0', '56', '0', '256559427328', '172622955520']
   ['fcs2', '0x20000120FA55DE74', '0x10000090FA55DE74', '8 GBIT', '8 GBIT', '0x0BDB80', 'Link Up', '0', '0', '0', '510002023680', '81960810240']
   ['fcs3', '0x20000120FA55DE75', '0x10000090FA55DE75', '8 GBIT', '8 GBIT', '0x0BDA80', 'Link Up', '0', '11', '0', '677410577152', '775436418304']

   (sysdata) $ HEADER=1 python digest-data.py data/ibm-aix-entstat.txt templates/ibm-aix-entstat.textfsm
   ['Device_Name', 'Device_Type', 'Hardware_Address', 'Link_Status', 'Link_Status_Reason', 'Media_Speed_Running', 'Jumbo_Frames', 'LSO', 'LRO', 'Priority', 'LAN_State', 'Hypervisor_Send_Failures', 'Hypervisor_Receiver_Failures', 'Hypervisor_Send_Errors', 'Hypervisor_Receive_Failures', 'Transmit_Errors', 'Receive_Errors', 'Transmit_Packets_Dropped', 'Receive_Packets_Dropped', 'DMA_Underrun', 'DMA_Overrun', 'Alignment_Errors', 'No_Resource_Errors', 'Packets_Discarded_by_Adapter']
   ['(ent5)', 'PCIe2 2-port 10GbE SR Adapter', '00:90:fa:79:4d:b7', 'Down', 'Local fault detected', '10 Gbps Full Duplex', 'Disabled', 'Enabled', 'Enabled', '', '', '', '', '', '', '10', '20', '30', '40', '50', '60', '70', '80', '90']
   ['(ent11)', 'PCIe2 2-port 10GbE SR Adapter', '00:90:fa:76:c4:5b', 'Down', 'Local fault detected', '10 Gbps Full Duplex', 'Disabled', 'Enabled', 'Enabled', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent4)', 'PCIe2 2-port 10GbE SR Adapter', '00:90:fa:79:4d:b6', 'Up', '', '', 'Disabled', 'Enabled', 'Disabled', '2', '', '', '', '', '', '0', '0', '0', '3', '0', '0', '0', '0', '0']
   ['(ent10)', 'PCIe2 2-port 10GbE SR Adapter', '00:90:fa:79:4d:b6', 'Up', '', '', 'Disabled', 'Enabled', 'Disabled', '', '', '', '', '', '', '0', '0', '0', '2', '0', '0', '0', '0', '0']
   ['(ent13)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:78:81:5c:ff', '', '', '', '', '', '', '2', 'Operational', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent12)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:78:81:5c:fe', '', '', '', '', '', '', '', 'Operational', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent16)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:7a:a2:a2:01', 'Up', '', '1000 Mbps Full Duplex', 'Enabled', '', '', '1', 'Operational', '3113470', '3113470', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent15)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:7a:a2:a2:00', '', '', '', '', '', '', '', 'Operational', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent19)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:7a:a2:a2:03', 'Up', '', '1000 Mbps Full Duplex', 'Enabled', '', '', '1', 'Operational', '3117433', '3117433', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent18)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:7a:a2:a2:02', '', '', '', '', '', '', '', 'Operational', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0']
   ['(ent24)', 'Virtual I/O Ethernet Adapter (l-lan)', '52:ae:7a:a2:a2:04', '', '', '', '', '', '', '', 'Operational', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'] 

   (sysdata) $ HEADER=1 python digest-data.py data/ds88k-showfbvol.txt templates/ibm-ds88k.textfsm
   ['Name', 'ID', 'accstate', 'datastate', 'deviceMTM', 'datatype', 'extpool', 'exts', 'cap', 'volgrp', 'ranks', 'sam', 'perfgrp', 'resgrp', 'GUID']
   ['E8802_vios3', '0000', 'Online', 'Normal', '2107-900', 'FB', 'P2', '200', '', 'V65', '7', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000000000']
   ['test', '0001', 'Online', 'Normal', '2107-900', 'FB', 'P0', '10', '', '-', '1', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000000001']
   ['E8802_vios3_', '0002', 'Online', 'Normal', '2107-900', 'FB', 'P2', '200', '', 'V65', '7', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000000002']
   ['E8801_VIOS2', '0003', 'Online', 'Normal', '2107-900', 'FB', 'P2', '100', '', 'V2', '7', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000000003']
   ['E8802_VIOS2', '0004', 'Online', 'Normal', '2107-900', 'FB', 'P2', '100', '', 'V7', '7', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000000004']
   ['E8801_VIOS1_', '0101', 'Online', 'Normal', '2107-900', 'FB', 'P1', '200', '', 'V66', '2', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000000101']
   ['E8801_VIOS2_B1', '7000', 'Online', 'Normal', '2107-900', 'FB', 'P2', '100', '', 'V2', '7', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000007000']
   ['E8802_VIOS2_B1', '7100', 'Online', 'Normal', '2107-900', 'FB', 'P3', '100', '', 'V7', '4', 'Standard', 'PG0', 'RG0', '6005076305FFD7CC0000000000007100']
   ```

## Setup
```
$ mkdir sysdata
$ virtualenv sysdata # python3 -m venv sysdata
$ source sysdata/bin/activate
(sysdata) $ cd sysdata
(sysdata) sysdata $ pip install textfsm # pip3 install textfsm
```
