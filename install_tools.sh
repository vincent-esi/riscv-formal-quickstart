#!/bin/bash

# Function to handle errors
error_handler() {
    echo "Error occurred in script at line: $1"
    exit 1
}

# Set trap to call error_handler function on ERR and EXIT signals
trap 'error_handler $LINENO' ERR
trap 'error_handler $LINENO' EXIT

# Create folder if it doesn't exist
mkdir -p riscv-formal-tools
cd riscv-formal-tools

# Install prerequisites
sudo apt-get install -y build-essential clang bison flex \
                     libreadline-dev gawk tcl-dev libffi-dev git \
                     graphviz xdot pkg-config python3 zlib1g-dev

python3 -m pip install click Verilog_VCD

# Install Yosys, Yosys-SMTBMC, and ABC
git clone https://github.com/YosysHQ/yosys
cd yosys
make -j$(nproc)
sudo make install
cd ..

# Install SymbiYosys
git clone https://github.com/YosysHQ/sby
cd sby
sudo make install
cd ..

# Install Boolector
git clone https://github.com/boolector/boolector
cd boolector
./contrib/setup-btor2tools.sh
./contrib/setup-lingeling.sh
./configure.sh
make -C build -j$(nproc)
sudo cp build/bin/{boolector,btor*} /usr/local/bin/
sudo cp deps/btor2tools/bin/btorsim /usr/local/bin/
cd ..

# Install riscv-formal
git clone https://github.com/YosysHQ/riscv-formal
cd riscv-formal
