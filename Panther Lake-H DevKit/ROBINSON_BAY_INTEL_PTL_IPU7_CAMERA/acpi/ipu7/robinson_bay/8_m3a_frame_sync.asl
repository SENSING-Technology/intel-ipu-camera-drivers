/*
 * SPDX-License-Identifier: GPL-2.0
 * Copyright (c) 2026 Intel Corporation.
 *
 * SSDT overlay: 8x Sensing M3A GMSL cameras with frame sync on Robinson Bay.
 *
 *   DES0 (MAX96724 2-trio CPHY, MIPI port 0)
 *     - Link 0: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *     - Link 1: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *     - Link 2: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *     - Link 3: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *
 *   DES1 (MAX96724 2-trio CPHY, MIPI port 2)
 *     - Link 0: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *     - Link 1: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *     - Link 2: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *     - Link 3: 4-lane Sensing M3A (MAX96717 SER @ 0x40)
 *
 * All four links on both deserializers are connected to ISX031 cameras.
 */

DefinitionBlock ("", "SSDT", 2, "", "IMG_ROB", 0x20260924)
{
    External (_SB.PC00, DeviceObj)

    Include ("_ipu.asl")

    Scope (\_SB.PC00)
    {
        Device (DES0)
        {
            #define EXTERNAL_FRAME_SYNC 0

            // DES-level defines for DES0
            #define DES_PHY_TYPE 0
            #define DES_I2C_ADDR 0x0027
            #define DES_LANES 2
            #define DES_INTERNAL_PHY 4
            #define DES_TO_MIPI_PORT 0
            #define DES_I2C_BUS "\\_SB.PC00.I2C0"
            #define DES_PATH "\\_SB.PC00.DES0"
            #define DES_REF \_SB.PC00.DES0
            #define DES_FSIN_GPIO_PIN 7
            #include "_des_common_max96724.asl"

            // Link 0 (Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH00
            #define DESCH_SER SER0
            #define DESCH_CAM CAM0
            #define DESCH_CH_PATH "\\_SB.PC00.DES0.CH00"
            #define DESCH_SER_PATH "\\_SB.PC00.DES0.CH00.SER0"
            #define DESCH_SER_REF \_SB.PC00.DES0.CH00.SER0
            #define DESCH_LINK_NUM 0
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER0
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x54
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
#ifdef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_RESET_GPIO
#endif
#ifdef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSIN_GPIO
#endif
#ifdef DESCH_SER_FSYNC_RX_ID
            #undef DESCH_SER_FSYNC_RX_ID
#endif
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Link 1 (Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH01
            #define DESCH_SER SER1
            #define DESCH_CAM CAM1
            #define DESCH_CH_PATH "\\_SB.PC00.DES0.CH01"
            #define DESCH_SER_PATH "\\_SB.PC00.DES0.CH01.SER1"
            #define DESCH_SER_REF \_SB.PC00.DES0.CH01.SER1
            #define DESCH_LINK_NUM 1
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER1
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x55
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
#ifdef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_RESET_GPIO
#endif
#ifdef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSIN_GPIO
#endif
#ifdef DESCH_SER_FSYNC_RX_ID
            #undef DESCH_SER_FSYNC_RX_ID
#endif
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Link 2 (Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH02
            #define DESCH_SER SER2
            #define DESCH_CAM CAM2
            #define DESCH_CH_PATH "\\_SB.PC00.DES0.CH02"
            #define DESCH_SER_PATH "\\_SB.PC00.DES0.CH02.SER2"
            #define DESCH_SER_REF \_SB.PC00.DES0.CH02.SER2
            #define DESCH_LINK_NUM 2
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER2
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x56
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
#ifdef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_RESET_GPIO
#endif
#ifdef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSIN_GPIO
#endif
#ifdef DESCH_SER_FSYNC_RX_ID
            #undef DESCH_SER_FSYNC_RX_ID
#endif
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Link 3 (Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH03
            #define DESCH_SER SER3
            #define DESCH_CAM CAM3
            #define DESCH_CH_PATH "\\_SB.PC00.DES0.CH03"
            #define DESCH_SER_PATH "\\_SB.PC00.DES0.CH03.SER3"
            #define DESCH_SER_REF \_SB.PC00.DES0.CH03.SER3
            #define DESCH_LINK_NUM 3
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER3
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x57
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
#ifdef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_RESET_GPIO
#endif
#ifdef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSIN_GPIO
#endif
#ifdef DESCH_SER_FSYNC_RX_ID
            #undef DESCH_SER_FSYNC_RX_ID
#endif
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Clean up DES-level defines
            #undef DES_PHY_TYPE
            #undef DES_I2C_ADDR
            #undef DES_LANES
            #undef DES_INTERNAL_PHY
            #undef DES_TO_MIPI_PORT
            #undef DES_I2C_BUS
            #undef DES_PATH
            #undef DES_REF
#ifdef DES_FSIN_GPIO_PIN
            #undef DES_FSIN_GPIO_PIN
#endif
#ifdef EXTERNAL_FRAME_SYNC
            #undef EXTERNAL_FRAME_SYNC
#endif
        }

        Device (DES1)
        {
            #define EXTERNAL_FRAME_SYNC 0

            // DES-level defines for DES1
            #define DES_PHY_TYPE 0
            #define DES_I2C_ADDR 0x0027
            #define DES_LANES 2
            #define DES_INTERNAL_PHY 6
            #define DES_TO_MIPI_PORT 2
            #define DES_I2C_BUS "\\_SB.PC00.I2C1"
            #define DES_PATH "\\_SB.PC00.DES1"
            #define DES_REF \_SB.PC00.DES1
            #define DES_FSIN_GPIO_PIN 7
            #include "_des_common_max96724.asl"

            // Link 0 ((Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH00
            #define DESCH_SER SER0
            #define DESCH_CAM CAM0
            #define DESCH_CH_PATH "\\_SB.PC00.DES1.CH00"
            #define DESCH_SER_PATH "\\_SB.PC00.DES1.CH00.SER0"
            #define DESCH_SER_REF \_SB.PC00.DES1.CH00.SER0
            #define DESCH_LINK_NUM 0
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER0
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x54
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
            #undef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSYNC_RX_ID
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Link 1 ((Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH01
            #define DESCH_SER SER1
            #define DESCH_CAM CAM1
            #define DESCH_CH_PATH "\\_SB.PC00.DES1.CH01"
            #define DESCH_SER_PATH "\\_SB.PC00.DES1.CH01.SER1"
            #define DESCH_SER_REF \_SB.PC00.DES1.CH01.SER1
            #define DESCH_LINK_NUM 1
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER1
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x55
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
            #undef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSYNC_RX_ID
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Link 2 ((Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH02
            #define DESCH_SER SER2
            #define DESCH_CAM CAM2
            #define DESCH_CH_PATH "\\_SB.PC00.DES1.CH02"
            #define DESCH_SER_PATH "\\_SB.PC00.DES1.CH02.SER2"
            #define DESCH_SER_REF \_SB.PC00.DES1.CH02.SER2
            #define DESCH_LINK_NUM 2
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER2
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x56
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
            #undef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSYNC_RX_ID
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Link 3 ((Sensing M3A MFP7 frame sync)
            #define DESCH_CH CH03
            #define DESCH_SER SER3
            #define DESCH_CAM CAM3
            #define DESCH_CH_PATH "\\_SB.PC00.DES1.CH03"
            #define DESCH_SER_PATH "\\_SB.PC00.DES1.CH03.SER3"
            #define DESCH_SER_REF \_SB.PC00.DES1.CH03.SER3
            #define DESCH_LINK_NUM 3
            #define DESCH_SER_I2C 0x40
            #define DESCH_SER_GPIOREF ^^SER3
            #define DESCH_SER_RESET_GPIO 0
            #define DESCH_SER_FSIN_GPIO 7
            #define DESCH_SER_FSYNC_RX_ID 7
            #define CAM_ALIAS 0x57
            #define CAM_LANES 4
            #include "_des_ch_common_m3a.asl"
            #undef DESCH_CH
            #undef DESCH_SER
            #undef DESCH_CAM
            #undef DESCH_CH_PATH
            #undef DESCH_SER_PATH
            #undef DESCH_SER_REF
            #undef DESCH_LINK_NUM
            #undef DESCH_SER_I2C
            #undef DESCH_SER_GPIOREF
            #undef DESCH_SER_RESET_GPIO
            #undef DESCH_SER_FSIN_GPIO
            #undef DESCH_SER_FSYNC_RX_ID
            #undef CAM_ALIAS
            #undef CAM_LANES

            // Clean up DES-level defines
            #undef DES_PHY_TYPE
            #undef DES_I2C_ADDR
            #undef DES_LANES
            #undef DES_INTERNAL_PHY
            #undef DES_TO_MIPI_PORT
            #undef DES_I2C_BUS
            #undef DES_PATH
            #undef DES_REF
            #undef DES_FSIN_GPIO_PIN
            #undef EXTERNAL_FRAME_SYNC
        }
    }
}
