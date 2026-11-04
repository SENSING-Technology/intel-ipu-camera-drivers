#!/bin/sh
set -eu

# # 30.01fps
# echo 0 | sudo tee /sys/class/pwm/pwmchip0/export
# echo 33322226| sudo tee /sys/class/pwm/pwmchip0/pwm0/period
# echo 16661113| sudo tee /sys/class/pwm/pwmchip0/pwm0/duty_cycle
# echo 1 | sudo tee /sys/class/pwm/pwmchip0/pwm0/enable

# 29.98fps
echo 0 | sudo tee /sys/class/pwm/pwmchip0/export
echo 33333333| sudo tee /sys/class/pwm/pwmchip0/pwm0/period
echo 16666666| sudo tee /sys/class/pwm/pwmchip0/pwm0/duty_cycle
echo 1 | sudo tee /sys/class/pwm/pwmchip0/pwm0/enable

# # 29fps
# echo 0 | sudo tee /sys/class/pwm/pwmchip0/export
# echo 34482758| sudo tee /sys/class/pwm/pwmchip0/pwm0/period
# echo 17241379| sudo tee /sys/class/pwm/pwmchip0/pwm0/duty_cycle
# echo 1 | sudo tee /sys/class/pwm/pwmchip0/pwm0/enable

# # 15fps
# echo 0 | sudo tee /sys/class/pwm/pwmchip0/export
# echo 66666666| sudo tee /sys/class/pwm/pwmchip0/pwm0/period
# echo 33333333| sudo tee /sys/class/pwm/pwmchip0/pwm0/duty_cycle
# echo 1 | sudo tee /sys/class/pwm/pwmchip0/pwm0/enable

