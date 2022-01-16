#!/bin/bash

for x in SIN_ COS_ ASIN ATAN EXP_ LOG_
do
  echo "==> $x <=="
  diff Z$x.b.gpu.dat Z$x.b.cpu.dat
done
