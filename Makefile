######################################################################
# makefile_ShapeType_main_i86Linux3gcc4.8.2#
# (c) Copyright, Real-Time Innovations, 2012.  All rights reserved.
# RTI grants Licensee a license to use, modify, compile, and create
# derivative works of the software solely for use with RTI Connext DDS.
# Licensee may redistribute copies of the software provided that all such
# copies are subject to this license. The software is provided "as is",
# with no warranty of any type, including any warranty for fitness for
# any purpose. RTI is under no obligation to maintain or support the
# software. RTI shall not be liable for any incidental or consequential
# damages arising out of the use or inability to use the software.
#
#
# This makefile assumes that your build environment is already correctly
# configured. (For example, the correct version of your compiler and
# linker should be on your PATH.)
######################################################################

# If undefined in the environment default NDDSHOME to install dir
ifndef NDDSHOME
NDDSHOME := "/home/andy/rti_connext_dds-6.0.1"
endif

SOURCE_DIR = 

TARGET_ARCH = i86Linux3gcc4.8.2

ifndef COMPILER
COMPILER = g++
endif
COMPILER_FLAGS = -m32 -Wall 
ifndef LINKER
LINKER = g++
endif
LINKER_FLAGS = -m32 -static-libgcc -Wl,--no-as-needed
SYSLIBS = -ldl -lnsl -lm -lpthread -lrt
DEFINES = -DRTI_UNIX -DRTI_LINUX -DRTI_CONNEXT_DDS
ifndef DEBUG
DEBUG=0 
endif
ifeq ($(DEBUG),1)
COMPILER_FLAGS += -g -O0
LINKER_FLAGS += -g
DEBUG_SFX = d
else
DEBUG_SFX = 
endif
 
ifndef SHAREDLIB
SHAREDLIB=0
endif

ifeq ($(SHAREDLIB),1)
SHAREDLIB_SFX = 
else
SHAREDLIB_SFX = z
DEFINES += -DRTI_STATIC
endif



INCLUDES = -I. -I$(NDDSHOME)/include -I$(NDDSHOME)/include/ndds 
       
LIBS = -L$(NDDSHOME)/lib/$(TARGET_ARCH) \
        -lnddscpp$(SHAREDLIB_SFX)$(DEBUG_SFX) \
        -lnddsc$(SHAREDLIB_SFX)$(DEBUG_SFX) \
        -lnddscore$(SHAREDLIB_SFX)$(DEBUG_SFX) \
        $(SYSLIBS)

SOURCES = \
  $(SOURCE_DIR)ShapeType_main.cxx \
  $(SOURCE_DIR)ShapeType.cxx \
  $(SOURCE_DIR)ShapeTypeSupport.cxx

OBJS = $(SOURCES:%.cxx=objs/$(TARGET_ARCH)/%.o)
EXEC          = ShapeType_main
DIRECTORIES   = objs.dir objs/$(TARGET_ARCH).dir


# We actually stick the objects in a sub directory to keep your directory clean.
$(TARGET_ARCH) : $(DIRECTORIES) $(OBJS) \
	$(EXEC:%=objs/$(TARGET_ARCH)/%.o) \
	$(EXEC:%=objs/$(TARGET_ARCH)/%)

objs/$(TARGET_ARCH)/% : objs/$(TARGET_ARCH)/%.o
	$(LINKER) $(LINKER_FLAGS)   -o $@ $@.o $(LIBS)

objs/$(TARGET_ARCH)/%.o : $(SOURCE_DIR)%.cxx   $(SOURCE_DIR)ShapeType.h 
	$(COMPILER) $(COMPILER_FLAGS)  -o $@ $(DEFINES) $(INCLUDES) -c $<

#
# Uncomment these lines if you want the support files regenerated when idl
# file is modified
#
#
$(SOURCE_DIR)ShapeTypePlugin.cxx \
$(SOURCE_DIR)ShapeType.cxx \
$(SOURCE_DIR)ShapeTypeSupport.cxx \
$(SOURCE_DIR)ShapeType.h \
$(SOURCE_DIR)ShapeTypePlugin.h \
$(SOURCE_DIR)ShapeTypeSupport.h : \
	$(SOURCE_DIR)ShapeType.idl
	$(NDDSHOME)/bin/rtiddsgen $(SOURCE_DIR)ShapeType.idl -replace -language C++
#
# Here is how we create those subdirectories automatically.
%.dir : 
	@echo "Checking directory $*"
	@if [ ! -d $* ]; then \
		echo "Making directory $*"; \
		mkdir -p $* ; \
	fi;
tell:
	echo SOURCES = $(SOURCES)
	echo OBJS = $(OBJS)

