#!/bin/sh

test_bin_dflt=./test/ctrl

# paths to ROC profiler and oher libraries
export LD_LIBRARY_PATH=$PWD
# enable error messages logging to '/tmp/rocprofiler_log.txt'
export ROCPROFILER_LOG=1

# ROC profiler library loaded by HSA runtime
export HSA_TOOLS_LIB=librocprofiler64.so
# tool library loaded by ROC profiler
export ROCP_TOOL_LIB=libtool.so
# ROC profiler metrics config file
unset ROCP_PROXY_QUEUE
# ROC profiler metrics config file
export ROCP_METRICS=metrics.xml
# output directory for the tool library, for metrics results file 'results.txt'
# and SQTT trace files 'thread_trace.se<n>.out'
export ROCP_OUTPUT_DIR=./RESULTS

if [ ! -e $ROCP_TOOL_LIB ] ; then
  export ROCP_TOOL_LIB=test/libtool.so
fi

if [ -n "$1" ] ; then
  tbin="$*"
else
  tbin=$test_bin_dflt
fi

export ROCP_KITER=100
export ROCP_DITER=100
export ROCP_INPUT=input.xml
eval $tbin

export ROCP_KITER=1
export ROCP_DITER=4
export ROCP_INPUT=input1.xml
eval $tbin

#valgrind --leak-check=full $tbin
#valgrind --tool=massif $tbin
#ms_print massif.out.<N>

exit 0
