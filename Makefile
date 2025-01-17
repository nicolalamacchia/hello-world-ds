# This is a stripped-down version of the Makefile from
# https://github.com/Patater/manual
# Refer to that manual to get started on programming Nintendo DS games
#
.SUFFIXES:

ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

include $(DEVKITARM)/ds_rules

#------------------------------------------------------------------------------
# TARGET is the name of the output
# BUILD is the directory where object files & intermediate files will be placed
# SOURCES is a list of directories containing source code
#------------------------------------------------------------------------------
TARGET   := $(shell basename $(CURDIR))
BUILD    := build
SOURCES  := src

# These set the information text in the nds file
GAME_TITLE     := Hello World DS
GAME_SUBTITLE1 := by Nicola Lamacchia
GAME_SUBTITLE2 := https://nicola.dev

# options for code generation
ARCH := -marm -mthumb-interwork -march=armv5te -mtune=arm946e-s

CFLAGS   := -g -Wall -O3\
            $(ARCH) $(INCLUDE) -DARM9
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions
ASFLAGS  := -g $(ARCH)
LDFLAGS   = -specs=ds_arm9.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)

# any extra libraries we wish to link with the project (order is important)
LIBS := -lnds9

# list of directories containing libraries, this must be the top level
# containing include and lib
LIBDIRS := $(LIBNDS) $(PORTLIBS)

#------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add
# additional rules for different file extensions
#------------------------------------------------------------------------------

ifneq ($(BUILD),$(notdir $(CURDIR)))

export OUTPUT := $(CURDIR)/$(TARGET)

export VPATH := $(CURDIR)/\
                $(foreach dir,$(SOURCES),$(CURDIR)/$(dir))\

export DEPSDIR := $(CURDIR)/$(BUILD)

CFILES   := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES   := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))

# use CXX for linking C++ projects, CC for standard C
ifeq ($(strip $(CPPFILES)),)
  export LD := $(CC)
else
  export LD := $(CXX)
endif

export OFILES   := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)
export INCLUDE  := $(foreach dir,$(INCLUDES),-iquote $(CURDIR)/$(dir))\
                   $(foreach dir,$(LIBDIRS),-I$(dir)/include)\
                   -I$(CURDIR)/$(BUILD)
export LIBPATHS := $(foreach dir,$(LIBDIRS),-L$(dir)/lib)

.PHONY: $(BUILD) clean

$(BUILD):
	@mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

clean:
	@echo clean ...
	@rm -fr $(BUILD) $(TARGET).elf $(TARGET).nds

else

# main targets
$(OUTPUT).nds: $(OUTPUT).elf
$(OUTPUT).elf: $(OFILES)

-include $(DEPSDIR)/*.d

endif
