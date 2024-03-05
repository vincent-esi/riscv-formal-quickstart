# # riscv-formal quickstart
This  assumes you are using Ubuntu 20.04 and above. You may run the included bash script to automatically install all the required software.
```
chmod +x install_tools.sh
./install_tools.sh
```

## Installation
### Prerequisites
```
sudo apt-get install build-essential clang bison flex \
                     libreadline-dev gawk tcl-dev libffi-dev git \
                     graphviz xdot pkg-config python3 zlib1g-dev

python3 -m pip install click Verilog_VCD
```

### Yosys, Yosys-SMTBMC and ABC
```
git clone https://github.com/YosysHQ/yosys
cd yosys
make -j$(nproc) // utilize multiple cores of processor
sudo make install
```

### SymbiYosys
```
git clone https://github.com/YosysHQ/sby
cd sby
sudo make install
```

### Boolector
```
git clone https://github.com/boolector/boolector
cd boolector
./contrib/setup-btor2tools.sh
./contrib/setup-lingeling.sh
./configure.sh
make -C build -j$(nproc)
sudo cp build/bin/{boolector,btor*} /usr/local/bin/
sudo cp deps/btor2tools/bin/btorsim /usr/local/bin/
```

### riscv-formal
```
git clone https://github.com/YosysHQ/riscv
cd riscv-formal
```

## Sample Verification
To verify that you have successfully installed the tools, run a test on a sample core.
```
cd cores/nerv/
make -j$(nproc) check
```
This should take a while and output passing tests.
