#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time 00:25:00
#SBATCH --exclusive
#SBATCH --export="NONE"
#SBATCH -p ndl

module load nvhpc

set -x
set -e

cd /home/gmap/mrpm/marguina/SAVE/scratch/BITREP

ulimit -s unlimited
export OMP_STACKSIZE=8Gb

./br_main.gpu.x
./br_main.cpu.x

