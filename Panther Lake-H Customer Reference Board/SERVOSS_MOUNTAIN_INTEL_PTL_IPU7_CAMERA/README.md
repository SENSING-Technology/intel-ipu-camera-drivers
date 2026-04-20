
## Linux kernel version

* Linux 6.17.11

## Supported camera list
* SG2-AR0233C-5200-G2A-HXXX
* SG3S-ISX031C-GMSL2F-HXXX
* SHF3L
* SHW3H
* SG3S-ISX031C-GMSL2G-HXXX
* SG5-IMX490C-5300-GMSL2-HXXX
* SG8S-AR0820C-5300-G2A-HXXX
* SG8-ISX028C-G2G-HXXX
* SG3-ISX031C-MIPI-HXXX

## Quick Start

#### 1. Install Kernel

Copy the driver package to the Panther Lake-H CRB (Ubuntu 24.04), then run the command below to install kernel.

```
cd SERVOSS_MOUNTAIN_INTEL_PTL_IPU7_CAMERA/
sudo dpkg -i deb/linux-headers-6.17.11-mainline-tracking-260128t080735z_6.17.11-1000_amd64.deb
sudo dpkg -i deb/linux-image-6.17.11-mainline-tracking-260128t080735z_6.17.11-1000_amd64.deb
```

#### 2. Update GRUB configuration

By default, the system uses the latest kernel version. After installation, update GRUB to make sure the installed kernel is used.

Run the command to view the kernel menuentry name.

```
sudo grep 6.17.11 /boot/grub/grub.cfg
```

Locate the menuentry containing "Ubuntu, with Linux 6.17.11-mainline-tracking-260128t080735z"，this is the target kernel.

file：/etc/default/grub

Configure the GRUB_DEFAULT and GRUB_CMDLINE_LINUX_DEFAULT fields as follows

```
GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 6.17.11-mainline-tracking-260128t080735z"
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash xe.max_vfs=7 xe.force_probe=* modprobe.blacklist=i915 udmabuf.list_limit=8192"
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

#### 3. Install IPU Components

```
cd ipu
unzip PTL-H_IPU_FW_HDMI-in_PV.zip
cd PTL-H_IPU_FW_HDMI-in_PV
```

Installing the essential tools

```
sudo ./installer.sh UBUNTU_NOBLE PTL mainline-tracking-overlay-v6.17.11-ubuntu-260128T080735Z default
```

Convert all the RPM packages to DEB packages and install them.
```
sudo apt install alien libjsoncpp25
sudo alien *.rpm 
sudo dpkg -i --force-overwrite icamerasrc_*.deb 
sudo dpkg -i --force-overwrite ipu7xfw_*.deb 
sudo dpkg -i --force-overwrite libiaaiq-ipu75xa_*.deb 
sudo dpkg -i --force-overwrite libiaaiq-ipu7x_*.deb 
sudo dpkg -i --force-overwrite ipu75xafw_*.deb 
sudo dpkg -i --force-overwrite libcamhal_*.deb
```

#### 4. Install the camera configuration file

```
cd SERVOSS_MOUNTAIN_INTEL_PTL_IPU7_CAMERA
cd config/ipu75xa/
sudo cp libcamhal_configs.json /etc/camera/ipu75xa/libcamhal_configs.json
sudo cp sensors/* /etc/camera/ipu75xa/sensors/
```

#### 5. Bring UP the GMSL Camera

Note: The configuration files in /etc/camera/ipu75xa/sensors/ default to 4 cameras per MAX96724 chip. If fewer than 4 cameras are connected, please update the configuration accordingly.

5.1 Hardware Connection

The camera module supports connectivity via MIPI D-PHY or C-PHY physical layer interfaces.

5.1.1 D-PHY Hardware Connection

D-PHY Jumper configuration

D-PHY Setup, C-PHY to D-PHY convert board is required.

5.1.2 C-PHY Hardware Connection

C-PHY Jumper configuration

C-PHY Setup


5.2 BIOS Setting

Intel Advanced Menu --> System Agent (SA) Configuatation --> MIPI Camera Configuration

Camera1: Enabled

Camera2: Enabled

Set the Link options as follows:

| | Camera1 Link options (DPHY) | Camera2 Link Options (DPHY) | Camera1 Link options (CPHY) | Camera2 Link Options (CPHY) |
|:---|:---|:---|:---|:---|
| Sensor Model | User Custom | User Custom | User Custom | User Custom |
| Custom HID | SGSM2M00 | SGSM2M00 | SGSM2M00 | SGSM2M00 |
| Lanes Clock division | 4 4 2 2 | 4 4 2 2 | 4 4 2 2 | 4 4 2 2 |
| CRD Version | CRD-D | CRD-D | CRD-D | CRD-D |
| GPIO control | No Control Logic | No Control Logic | No Control Logic | No Control Logic |
| Camera position | Front | Back | Front | Back |
| Flash Support | Disabled | Disabled | Disabled | Disabled |
| Privacy LED | Driver default | Driver default | Driver default | Driver default |
| Rotation | 180 | 0 | 180 | 0 |
| Voltage Rail | | 3 voltage rail | | 3 voltage rail |
| PhyConfiguration | DPHY | DPHY | CPHY | CPHY |
| PPR Value | 4 | 2 | 2 | 2 |
| PPR Unit | 4 | 4 | 4 | 4 |
| Camera module name | MAX96724 | MAX96724 | MAX96724 | MAX96724 |
| MIPI port | 0 | 2 | 0 | 2 |
| LaneUsed | x4 | x4 | x4 | x4 |
| MCLK | 19200000 | 19200000 | 19200000 | 19200000 |
| EEPROM Type | ROM_NONE | ROM_NONE | ROM_NONE | ROM_NONE |
| VCM Type | VCM_NONE | VCM_NONE | VCM_NONE | VCM_NONE |
| Number of I2C Components | 3 | 3 | 3 | 3 |
| I2C Channel | I2C1 | I2C2 | I2C1 | I2C2 |
| Device 0 | | | | |
| I2C Address | 27 | 27 | 27 | 27 |
| Device Type | Sensor | Sensor | Sensor | Sensor |
| Device 1 | | | | |
| I2C Address | 44 | 44 | 44 | 44 |
| Device Type | Sensor | Sensor | Sensor | Sensor |
| Device 2 | | | | |
| I2C Address | 54 | 54 | 54 | 54 |
| Device Type | Sensor | Sensor | Sensor | Sensor |
| Customize Device ID List | | | | |
| Customize Device ID Number | 17 | 17 | 17 | 17 |
| Customize Device ID Number | 18 | 18 | 18 | 18 |
| Customize Device ID Number | 19 | 19 | 19 | 19 |
| Flash Driver Selection | Disabled | Disabled | Disabled | Disabled |


5.3 Bring up GMSL Camera

5.3.1 Configure environment variables

```
sudo su

export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri 
#export XDG_RUNTIME_DIR=/tmp 
export LIBVA_DRIVER_NAME=iHD 
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig 
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib64:/usr/lib:/usr/lib/x86_64-linux-gnu 
export GST_PLUGIN_PATH=/usr/lib/gstreamer-1.0 
export GST_GL_PLATFORM=egl 
export GST_GL_API=gles2 
export logSink=terminal 
rm -rf ~/.cache/gstreamer-1.0
```

5.3.2 For SG2-AR0233C-5200-G2A-HXXX Camera

Set the Custom HID option in the BIOS to SGSM2M00.

Bring up a single camera
```
gst-launch-1.0 icamerasrc scene-mode=auto device-name=ar0233c-1 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false
```

Bring up two camera
```
gst-launch-1.0 icamerasrc num-vc=2 scene-mode=auto device-name=ar0233c-1 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233c-2 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false
```

Bring up four camera
```
gst-launch-1.0 icamerasrc num-vc=4 scene-mode=auto device-name=ar0233c-1 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233c-2 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233c-3 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false icamerasrc num-vc=4 scene-mode=auto device-name=ar0233c-4 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1080' ! glimagesink sync=false
```

5.3.3 For SG3S-ISX031C-GMSL2F-HXXX Camera

Set the Custom HID option in the BIOS to SGSM3M00.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: isx031f-1 to isx031f-8
width: 1920
height: 1536
```

5.3.4 For SHF3L Camera

Set the Custom HID option in the BIOS to SGSM3M01.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: shf3l-1 to shf3l-8
width: 1920
height: 1536
```

5.3.5 For SHW3H Camera

Set the Custom HID option in the BIOS to SGSM3M02.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: shw3h-1 to shw3h-8
width: 1920
height: 1536
```

5.3.6 For SG3S-ISX031C-GMSL2G-HXXX Camera

Set the Custom HID option in the BIOS to SGSM3M03.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: isx031g-1 to isx031g-8
width: 1920
height: 1536
```

5.3.7 For SG5-IMX490C-5300-GMSL2-HXXX Camera

Set the Custom HID option in the BIOS to SGSM5M00.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: imx490c-1 to imx490c-8
width: 2880
height: 1860
```

5.3.8 For SG8S-AR0820C-5300-G2A-HXXX Camera

Set the Custom HID option in the BIOS to SGSM8M00.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: ar0820c-1 to ar0820c-8
width: 3840
height: 2160
```

5.3.9 For SG8-ISX028C-G2G-HXXX Camera

Set the Custom HID option in the BIOS to SGSM8M01.

Reference Commands for SG2-AR0233C-5200-G2A-HXXX Camera.

Parameters:
```
device-name: isx028c-1 to isx028c-8
width: 3840
height: 2160
```

#### 6. Bring up MIPI Camera

6.1 Hardware Connection

MIPI Camera Setup, C-PHY to D-PHY convert board is required.

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
| Group Pad Number | 10 | 1 |
| Group Number | C_D_E_H | C_D_E_H |
| Com Number | COM1 | COM1 |
| Function | RESET | RESET |
| Active Value | 1 | 1 |
| Initial Value | 0 | 0 |


Intel Advanced Menu --> System Agent (SA) Configuatation --> MIPI Camera Configuration
Camera1: Enabled

Camera2: Enabled

Set the Link options as follows:

| | Camera1 Link options | Camera2 Link Options |
| :--- | :--- | :--- |
| Sensor Model | Custom Display Bridge | Custom Display Bridge |
| Audio HID | – | – |
| Custom HID | SGXX3M00 | SGXX3M00 |
| Lanes Clock division | 4 4 2 2 | 4 4 2 2 |
| CRD Version | CRD-D | CRD-D |
| GPIO control | Control Logic 1 | Control Logic 2 |
| Camera position | Front | Back |
| Flash Support | Disabled | Disabled |
| Privacy LED | Driver default | Driver default |
| Rotation | 0 | 0 |
| Voltage Rail | | 3 voltage rail |
| PhyConfiguration | DPHY | DPHY |
| PPR Value | 0 | 0 |
| PPR Unit | 0 | 0 |
| Camera module name | – | – |
| MIPI port | 0 | 2 |
| LaneUsed | x4 | x2 |
| MCLK | 19200000 | 19200000 |
| EEPROM Type | ROM_NONE | ROM_NONE |
| VCM Type | VCM_NONE | VCM_NONE |
| Number of I2C Components | 1 | 1 |
| I2C Channel | I2C1 | I2C2 |
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
sudo su

export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri 
#export XDG_RUNTIME_DIR=/tmp 
export LIBVA_DRIVER_NAME=iHD 
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/lib/pkgconfig 
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib64:/usr/lib:/usr/lib/x86_64-linux-gnu 
export GST_PLUGIN_PATH=/usr/lib/gstreamer-1.0 
export GST_GL_PLATFORM=egl 
export GST_GL_API=gles2 
export logSink=terminal 
rm -rf ~/.cache/gstreamer-1.0
```

6.3.2 For SG3-ISX031C-MIPI-HXXX Camera

Set the Custom HID option in the BIOS to SGXX3M00.

Bring up a first camera
```
gst-launch-1.0 icamerasrc scene-mode=auto device-name=isx031c_mipi-1 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1536' ! glimagesink sync=false
```

Bring up the second camera
```
gst-launch-1.0 icamerasrc scene-mode=auto device-name=isx031c_mipi-2 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf),drm-format=UYVY,width=1920,height=1536' ! glimagesink sync=false
```
