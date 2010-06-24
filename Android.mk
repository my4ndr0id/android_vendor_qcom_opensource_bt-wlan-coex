#--------------------------------------------------------------------------
#Copyright (c) 2009-2010, Code Aurora Forum. All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of Code Aurora nor
#      the names of its contributors may be used to endorse or promote
#      products derived from this software without specific prior written
#      permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#--------------------------------------------------------------------------

# Build the Coex solution for BlueZ + Libra: BT Coex Shim, BTC-ES
# But only for builds with the Libra WLAN

ifeq ($(BOARD_HAVE_BLUETOOTH), true)
ifeq ($(BOARD_HAS_QCOM_WLAN), true)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

# BlueZ Includes
BLUEZ_ROOT := $(LOCAL_PATH)/../../../../external/bluetooth/bluez/include/bluetooth

# This is used by BT Coex Shim and BTC-ES
ifeq ($(TARGET_BUILD_TYPE),debug)
LOCAL_CFLAGS += -DBTC_DEBUG
LOCAL_CFLAGS += -DBTCES_DEBUG
endif

# BTC make does this, ensure compatibility
LOCAL_CFLAGS += \
        -fno-short-enums 

LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/btc
LOCAL_C_INCLUDES += $(LOCAL_PATH)/btces
LOCAL_C_INCLUDES += $(BLUEZ_ROOT)
LOCAL_C_INCLUDES += $(call include-path-for, dbus)

LOCAL_STATIC_LIBRARIES := \
        libbluez-common-static

LOCAL_SHARED_LIBRARIES := \
        libdbus \
        libbluetooth

LOCAL_SRC_FILES := \
        bt_coex_shim.cpp \
        btc/wlan_btc_usr_svc.c \
        btces/btces_api.cpp \
        btces/btces_pfal.cpp

# This library is for BT Coex using BlueZ stack with Qualcomm (Libra) WLAN
LOCAL_MODULE := btwlancoex
LOCAL_MODULE_TAGS := eng

LOCAL_PRELINK_MODULE := false
include $(BUILD_EXECUTABLE)

endif # BOARD_HAS_QCOM_WLAN
endif # BOARD_HAVE_BLUETOOTH

