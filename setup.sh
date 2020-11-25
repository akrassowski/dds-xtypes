#!/bin/bash

sudo apt-get install make gcc g++ -y
sudo apt-get install gcc-multilib g++-multilib -y

$NDDSHOME/bin/rtiddsgen ShapeType.idl -ppDisable -language C++ -update typefiles -update examplefiles -update makefiles -platform i86Linux3gcc4.8.2

make -f make*


