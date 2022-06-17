#!/usr/bin/env bash
#
# AMDGPU-PRO OVERCLOCKS
#
# git clone https://github.com/bryanhohs/amdmemorytweak.git
#
# cd amdmemorytweak/linux && g++ AmdMemTweak.cpp -lpci -lresolv -o amdmemtweak
#
################################################################################

cclock="1209"      # core clocks 
cvddc="850"        # core voltage 
mclock="2200"      # memory clocks
mvddc="900"        # memory voltage
fans="255"         # static fan percentage

##################################DO NOT EDIT###################################

for i in /sys/class/drm/card*/device/hwmon/hwmon*/pwm1_enable; do
	echo 1 > $i;
done

for i in /sys/class/drm/card*/device/power_dpm_force_performance_level; do
	echo manual > $i;
done

for i in /sys/class/drm/card*/device/hwmon/hwmon*/pwm1; do
	echo $fans > $i;
done

for i in /sys/class/drm/card*/device/pp_od_clk_voltage; do
	echo "s 1 $cclock $cvddc" > $i;
	echo "s 2 $cclock $cvddc" > $i;
	echo "s 3 $cclock $cvddc" > $i;
	echo "s 4 $cclock $cvddc" > $i;
	echo "s 5 $cclock $cvddc" > $i;
	echo "s 6 $cclock $cvddc" > $i;
	echo "s 7 $cclock $cvddc" > $i;
done

for i in /sys/class/drm/card*/device/pp_od_clk_voltage; do
	echo "m 1 $mclock $mvddc" > $i;
	echo "m 2 $mclock $mvddc" > $i;
done

for i in /sys/class/drm/card*/device/pp_od_clk_voltage; do
        echo c > $i;
done

for i in /sys/class/drm/card*/device/pp_dpm_mclk; do
        echo 2 > $i;
done

for i in /sys/class/drm/card*/device/pp_dpm_sclk; do
        echo 6 > $i;
done

amdmemtweak --REF 30 > /dev/null 2>&1;

exit 0
