#******************************************************************************
#
# Makefile - Rules for building the CAN FIFO mode example.
#
# Copyright (c) 2009-2012 Texas Instruments Incorporated.  All rights reserved.
# Software License Agreement
# 
# Texas Instruments (TI) is supplying this software for use solely and
# exclusively on TI's microcontroller products. The software is owned by
# TI and/or its suppliers, and is protected under applicable copyright
# laws. You may not combine this software with "viral" open-source
# software in order to form a larger program.
# 
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
# NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
# NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. TI SHALL NOT, UNDER ANY
# CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES, FOR ANY REASON WHATSOEVER.
# 
# This is part of revision 9107 of the EK-LM3S8962 Firmware Package.
#
#******************************************************************************

#
# Defines the part type that this project uses.
#
PART=LM3S2965

#
# Set the processor variant.
#
VARIANT=cm3

#
# The base directory
#
ROOT=../

#
# Include the common make definitions.
#
include ${ROOT}/makedefs

#
# Where to find source files that do not live in this directory.
#
VPATH=../drivers
VPATH+=../utils

#
# Where to find header files that do not live in the source directory.
#
IPATH=.
IPATH+=..
#IPATH+=../lwip-1.3.2/apps
IPATH+=../lwip-1.3.2/ports/stellaris/include
IPATH+=../lwip-1.3.2/src/include
IPATH+=../lwip-1.3.2/src/include/ipv4

#
# The default rule, which causes the project to be built.
#
all: ${COMPILER}
all: ${COMPILER}/can_ethernet.axf

#
# The rule to clean out all the build products.
#
clean:
	@rm -rf ${COMPILER} ${wildcard *~}

#
# Install - copy to vm_share for now to make available to LM Flash Programmer
#
install:
	@cp gcc/can_ethernet.bin /home/hartmut/vm_share

#
# The rule to create the target directory.
#
${COMPILER}:
	@mkdir -p ${COMPILER}

#
# Rules for building the CAN FIFO mode example.
#
${COMPILER}/can_ethernet.axf: ${COMPILER}/can_ethernet.o
${COMPILER}/can_ethernet.axf: ${COMPILER}/rit128x96x4.o
${COMPILER}/can_ethernet.axf: ${COMPILER}/startup_${COMPILER}.o
${COMPILER}/can_ethernet.axf: ${COMPILER}/lwiplib.o
${COMPILER}/can_ethernet.axf: ${COMPILER}/ustdlib.o
${COMPILER}/can_ethernet.axf: ${ROOT}/driverlib/${COMPILER}-cm3/libdriver-cm3.a
${COMPILER}/can_ethernet.axf: can_ethernet.ld
SCATTERgcc_can_ethernet=can_ethernet.ld
ENTRY_can_ethernet=RESET_handler

#
# Include the automatically generated dependency files.
#
ifneq (${MAKECMDGOALS},clean)
-include ${wildcard ${COMPILER}/*.d} __dummy__
endif
