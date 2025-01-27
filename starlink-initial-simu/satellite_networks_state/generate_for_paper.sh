# The MIT License (MIT)
#
# Copyright (c) 2020 ETH Zurich
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Usage help
if [ "$1" == "--help" ] || [ "$#" != "2" ]; then
    echo "Usage: bash generate_for_paper.sh [data points: 50, 100, 1000] [number of threads]"
    echo "
Workloads:
  50   - Starlink simulation with 50 data points
  100  - Starlink simulation with 100 data points
  1000 - Starlink simulation with 1000 data points

Example:
  bash generate_for_paper.sh 50 4
    (Runs the Starlink simulation with 50 data points using 4 threads)"
    exit 0
fi

# Fetch arguments
data_points="$1"
num_threads=$2

# Check validity of arguments
if [ "$data_points" != "50" ] && [ "$data_points" != "100" ] && [ "$data_points" != "1000" ]; then
    echo "Invalid workload: $data_points. Please choose one of the following workloads:"
    echo "  50   - Starlink simulation with 50 data points"
    echo "  100  - Starlink simulation with 100 data points"
    echo "  1000 - Starlink simulation with 1000 data points"
    exit 1
fi
if [ "$num_threads" -lt "0" ] || [ "$num_threads" -gt "128" ]; then
    echo "Invalid number of threads: $num_threads. Please specify a value between 0 and 128."
    exit 1
fi

# Print what is being run
echo "Running Starlink workload with $data_points data points and $num_threads threads"

# Starlink-550 with ISLs
if [ "$data_points" = "50" ]; then
    echo "Executing: Starlink simulation with 50 data points"
    python main_starlink_550.py 200 50 isls_plus_grid ground_stations_top_100 algorithm_free_one_only_over_isls $num_threads
fi
if [ "$data_points" = "100" ]; then
    echo "Executing: Starlink simulation with 100 data points"
    python main_starlink_550.py 200 100 isls_plus_grid ground_stations_top_100 algorithm_free_one_only_over_isls $num_threads
fi
if [ "$data_points" = "1000" ]; then
    echo "Executing: Starlink simulation with 1000 data points"
    python main_starlink_550.py 200 1000 isls_plus_grid ground_stations_top_100 algorithm_free_one_only_over_isls $num_threads
fi