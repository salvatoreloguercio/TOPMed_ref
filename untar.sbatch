#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1

echo "workdir: $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR

tar -xvf $input
