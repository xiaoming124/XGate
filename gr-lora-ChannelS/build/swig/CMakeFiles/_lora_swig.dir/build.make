# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ningning/gr-lora-master-nt

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ningning/gr-lora-master-nt/build

# Include any dependencies generated for this target.
include swig/CMakeFiles/_lora_swig.dir/depend.make

# Include the progress variables for this target.
include swig/CMakeFiles/_lora_swig.dir/progress.make

# Include the compile flags for this target's objects.
include swig/CMakeFiles/_lora_swig.dir/flags.make

swig/lora_swigPYTHON_wrap.cxx: swig/lora_swig_swig_2d0df
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/ningning/gr-lora-master-nt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating lora_swigPYTHON_wrap.cxx"

swig/lora_swig.py: swig/lora_swig_swig_2d0df
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/ningning/gr-lora-master-nt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating lora_swig.py"

swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o: swig/CMakeFiles/_lora_swig.dir/flags.make
swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o: swig/lora_swigPYTHON_wrap.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ningning/gr-lora-master-nt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o"
	cd /home/ningning/gr-lora-master-nt/build/swig && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Wno-unused-but-set-variable -o CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o -c /home/ningning/gr-lora-master-nt/build/swig/lora_swigPYTHON_wrap.cxx

swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.i"
	cd /home/ningning/gr-lora-master-nt/build/swig && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Wno-unused-but-set-variable -E /home/ningning/gr-lora-master-nt/build/swig/lora_swigPYTHON_wrap.cxx > CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.i

swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.s"
	cd /home/ningning/gr-lora-master-nt/build/swig && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -Wno-unused-but-set-variable -S /home/ningning/gr-lora-master-nt/build/swig/lora_swigPYTHON_wrap.cxx -o CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.s

swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.requires:

.PHONY : swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.requires

swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.provides: swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.requires
	$(MAKE) -f swig/CMakeFiles/_lora_swig.dir/build.make swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.provides.build
.PHONY : swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.provides

swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.provides.build: swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o


# Object files for target _lora_swig
_lora_swig_OBJECTS = \
"CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o"

# External object files for target _lora_swig
_lora_swig_EXTERNAL_OBJECTS =

swig/_lora_swig.so: swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o
swig/_lora_swig.so: swig/CMakeFiles/_lora_swig.dir/build.make
swig/_lora_swig.so: /usr/lib/x86_64-linux-gnu/libpython2.7.so
swig/_lora_swig.so: lib/libgnuradio-lora.so
swig/_lora_swig.so: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
swig/_lora_swig.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
swig/_lora_swig.so: /usr/local/lib/libgnuradio-runtime.so
swig/_lora_swig.so: /usr/local/lib/libgnuradio-pmt.so
swig/_lora_swig.so: /usr/local/lib/libgnuradio-blocks.so
swig/_lora_swig.so: /usr/local/lib/libgnuradio-fft.so
swig/_lora_swig.so: /usr/local/lib/libvolk.so
swig/_lora_swig.so: swig/CMakeFiles/_lora_swig.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ningning/gr-lora-master-nt/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX shared module _lora_swig.so"
	cd /home/ningning/gr-lora-master-nt/build/swig && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/_lora_swig.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
swig/CMakeFiles/_lora_swig.dir/build: swig/_lora_swig.so

.PHONY : swig/CMakeFiles/_lora_swig.dir/build

swig/CMakeFiles/_lora_swig.dir/requires: swig/CMakeFiles/_lora_swig.dir/lora_swigPYTHON_wrap.cxx.o.requires

.PHONY : swig/CMakeFiles/_lora_swig.dir/requires

swig/CMakeFiles/_lora_swig.dir/clean:
	cd /home/ningning/gr-lora-master-nt/build/swig && $(CMAKE_COMMAND) -P CMakeFiles/_lora_swig.dir/cmake_clean.cmake
.PHONY : swig/CMakeFiles/_lora_swig.dir/clean

swig/CMakeFiles/_lora_swig.dir/depend: swig/lora_swigPYTHON_wrap.cxx
swig/CMakeFiles/_lora_swig.dir/depend: swig/lora_swig.py
	cd /home/ningning/gr-lora-master-nt/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ningning/gr-lora-master-nt /home/ningning/gr-lora-master-nt/swig /home/ningning/gr-lora-master-nt/build /home/ningning/gr-lora-master-nt/build/swig /home/ningning/gr-lora-master-nt/build/swig/CMakeFiles/_lora_swig.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : swig/CMakeFiles/_lora_swig.dir/depend

