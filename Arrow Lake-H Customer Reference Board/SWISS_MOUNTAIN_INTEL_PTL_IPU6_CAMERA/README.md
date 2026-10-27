
## Linux kernel version

* Linux 6.12.36

## Supported camera list
* SG2-AR0233C-5200-G2A-HXXX
* SG3S-ISX031C-GMSL2F-HXXX
* SHF3L
* SHW3H
* SG5-IMX490C-5300-GMSL2-HXXX
* SG8S-AR0820C-5300-G2A-HXXX
* SG8-ISX028C-G2G-HXXX
* SG3-ISX031C-MIPI-HXXX

## Quick Start

#### 1. Install Kernel

Copy the driver package to the Arrow Lake-U/H CRB (Ubuntu 24.04), then run the command below to install kernel.

```
cd SWISS_MOUNTAIN_INTEL_PTL_IPU6_CAMERA/
sudo dpkg -i deb/linux-headers-6.12.36-lts-250711t071314z_6.12.36-1000_amd64.deb
sudo dpkg -i deb/linux-image-6.12.36-lts-250711t071314z_6.12.36-1000_amd64.deb
```

#### 2. Update GRUB configuration

By default, the system uses the latest kernel version. After installation, update GRUB to make sure the installed kernel is used.

Run the command to view the kernel menuentry name.

```
sudo grep 6.12.36 /boot/grub/grub.cfg
```

Locate the menuentry containing "Ubuntu, with Linux 6.12.36-lts-250711t071314z"，this is the target kernel.

file：/etc/default/grub

Configure the GRUB_DEFAULT and GRUB_CMDLINE_LINUX_DEFAULT fields as follows

```
GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 6.12.36-lts-250711t071314z"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.enable_guc=3 i915.max_vfs=7 i915.force_probe=* udmabuf.list_limit=8192 console=tty0 console=ttyS0,115200n8 console=tty0 console=ttyS0,115200n8"
```

Once saved, run the command.

```
sudo update-grub
sudo reboot
```

After rebooting, check the kernel version.

```
uname -a
```

#### 3. Install icamerasrc

```
sudo add-apt-repository ppa:oem-solutions-group/intel-ipu6
sudo apt install libcamhal-ipu6
sudo apt install libcamhal-ipu6epmtl
```

Set the isys frequency

```
sudo vi /etc/modprobe.d/ipu.conf

options intel_ipu6 isys_freq_override=400
```

#### 4. Install the camera configuration file

```
cd SWISS_MOUNTAIN_INTEL_PTL_IPU6_CAMERA
cd config/ipu6epmtl/
sudo cp libcamhal_profile.xml /etc/camera/ipu6epmtl/libcamhal_profile.xml
sudo cp sensors/* /etc/camera/ipu6epmtl/sensors/
```

#### 5. Bring UP the GMSL Camera

5.1 Hardware Connection

Connect the camera and the adapter board according to the actual connection path.

5.2 BIOS Setting

Intel Advanced Menu --> System Agent (SA) Configuatation --> MIPI Camera Configuration

Camera1: Enabled

Camera2: Enabled

Set the Link options as follows:

| | Camera1 Link options | Camera2 Link Options |
|:---|:---|:---|
| Sensor Model | User Custom | User Custom |
| Custom HID | SGMX2M00 | SGMX2M00 |
| Lanes Clock division | 4 4 2 2 | 4 4 2 2 |
| CRD Version | CRD-D | CRD-D |
| GPIO control | No Control Logic | No Control Logic |
| Camera position | Front | Back |
| Flash Support | Driver default | Driver default |
| Privacy LED | Driver default | Driver default |
| Rotation | 0 | 0 |
| Voltage Rail | | 3 voltage rail |
|  |                      |  |
| PPR Value | 4 | 4 |
| PPR Unit | 2 | 2 |
| Camera module name | 09B13 | A12N08B |
| MIPI port | 0 | 4 |
| LaneUsed | x4 | x4 |
| MCLK | 19200000 | 19200000 |
| EEPROM Type | ROM_NONE | ROM_NONE |
| VCM Type | VCM_NONE | VCM_NONE |
| Number of I2C Components | 3 | 3 |
| I2C Channel | I2C1 | I2C0 |
| Device 0 | | |
| I2C Address | 48 | 48 |
| Device Type | Sensor | Sensor |
| Device 1 | | |
| I2C Address | 44 | 44 |
| Device Type | Sensor | Sensor |
| Device 2 | | |
| I2C Address | 40 | 40 |
| Device Type | Sensor | Sensor |
| Customize Device ID List | | |
| Customize Device ID Number | 17 | 17 |
| Customize Device ID Number | 18 | 18 |
| Customize Device ID Number | 19 | 19 |
| Flash Driver Selection | Disabled | Disabled |


5.3 Bring up GMSL Camera

5.3.1 Configure environment variables

```
xhost +
```

5.3.2 For SG2-AR0233C-5200-G2A-HXXX Camera

Set the Custom HID option in the BIOS to SGMX2M00.

Bring up a single camera
```
sudo gst-launch-1.0 icamerasrc num-vc=1 device-name=ar0233c-1 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false
```

Bring up two camera
```
sudo gst-launch-1.0 icamerasrc num-vc=2 scene-mode=auto device-name=ar0233cx2-1 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false icamerasrc num-vc=2 scene-mode=auto device-name=ar0233cx2-2 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false
```

Bring up four camera
```
sudo gst-launch-1.0 icamerasrc num-vc=4 scene-mode=auto device-name=ar0233cx4-1 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233cx4-2 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233cx4-3 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233cx4-4 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1080 ! glimagesink sync=false
```

5.3.3 For SG3S-ISX031C-GMSL2F-HXXX Camera

Set the Custom HID option in the BIOS to SGMX3M00.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: isx031f-1 to isx031f-4
width: 1920
height: 1536
```

5.3.4 For SHF3L Camera

Set the Custom HID option in the BIOS to SGMX3M01.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: shf3l-1 to shf3l-4
width: 1920
height: 1536
```

5.3.5 For SHW3H Camera

Set the Custom HID option in the BIOS to SGMX3M02.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: shw3h-1 to shw3h-4
width: 1920
height: 1536
```

5.3.6 For SG5-IMX490C-5300-GMSL2-HXXX Camera

Set the Custom HID option in the BIOS to SGMX5M00.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: imx490c-1 to imx490c-4
width: 2880
height: 1860
```

5.3.8 For SG8S-AR0820C-5300-G2A-HXXX Camera

Set the Custom HID option in the BIOS to SGMX8M00.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: ar0820c-1 to ar0820c-4
width: 3840
height: 2160
```

5.3.9 For SG8-ISX028C-G2G-HXXX Camera

Set the Custom HID option in the BIOS to SGMX8M01.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: isx028c-1 to isx028c-4
width: 3840
height: 2160
```

#### 6. Bring up MIPI Camera

6.1 Hardware Connection

MIPI Camera Setup

6.2 BIOS Setting

Intel Advanced Menu --> System Agent (SA) Configuatation --> MIPI Camera Configuration

Control Logic 1: Enabled

Control Logic 2: Enabled

Set the Control Logic options as follows:

| | Control Logic 1 | Control Logic 2 |
| :--- | :--- | :--- |
| Control Logic Type | Discrete | Discrete |
| CRD Version | CRD-D | CRD-D |
| Input Clock | 19.2MHz | 19.2MHz |
| PCH Clock Source | IMGCLKOUT_0 | IMGCLKOUT_1 |
| Number of GPIOs | 1 | 1 |
| GPIO Pin 0 | | |
| Group Pad Number | 23 | 0 |
| Group Number | D_E_F_U | A_B_H_S |
| Com Number | COM0 | COM3 |
| Function | RESET | RESET |
| Active Value | 0 | 0 |
| Initial Value | 0 | 0 |


Intel Advanced Menu --> System Agent (SA) Configuatation --> MIPI Camera Configuration
Camera1: Enabled

Camera2: Enabled

Set the Link options as follows:

| | Camera1 Link options | Camera2 Link Options |
| :--- | :--- | :--- |
| Sensor Model | User Custom | User Custom |
|  | – | – |
| Custom HID | SGXX3M00 | SGXX3M00 |
| Lanes Clock division | 4 4 2 2 | 4 4 2 2 |
| CRD Version | CRD-D | CRD-D |
| GPIO control | Control Logic 1 | Control Logic 2 |
| Camera position | Front | Back |
| Flash Support | Driver default | Driver default |
| Privacy LED | Driver default | Driver default |
| Rotation | 0 | 0 |
| Voltage Rail | | 3 voltage rail |
|                            |                      |                      |
| PPR Value | 0 | 1 |
| PPR Unit | A | A |
| Camera module name | 09B13 | A12N08B |
| MIPI port | 0 | 4 |
| LaneUsed | x4 | x4 |
| MCLK | 19200000 | 19200000 |
| EEPROM Type | ROM_NONE | ROM_NONE |
| VCM Type | VCM_NONE | VCM_NONE |
| Number of I2C Components | 1 | 1 |
| I2C Channel | I2C1 | I2C0 |
| Device 0 | | |
| I2C Address | 1A | 1A |
| Device Type | Sensor | Sensor |
| Customize Device ID List | | |
| Customize Device ID Number | 17 | 17 |
| Customize Device ID Number | 18 | 18 |
| Customize Device ID Number | 19 | 19 |
| Flash Driver Selection | Disabled | Disabled |

6.3 Bring up MIPI Camera

6.3.1 Configure environment variables

```
xhost +
```

6.3.2 For SG3-ISX031C-MIPI-HXXX Camera

Set the Custom HID option in the BIOS to SGXX3M00.

Bring up a first camera
```
sudo gst-launch-1.0 icamerasrc num-vc=1 device-name=isx031c_mipi-1 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink sync=false
```

Bring up the second camera
```
sudo gst-launch-1.0 icamerasrc num-vc=1 device-name=isx031c_mipi-2 io-mode=dma_mode printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink sync=false
```
