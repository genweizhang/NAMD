#!/bin/bash
#SBATCH --partition=64gb_24core
#SBATCH --ntasks=24
#SBATCH --ntasks-per-node=24
#SBATCH --mem=0
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --time=04:00:00
#SBATCH --job-name=mmpbsa

source /home/panxl/amber16/amber.sh
/home/panxl/.local/bin/mpirun -np ${SLURM_NTASKS} MMPBSA.py.MPI -O -i mmpbsa.in -o FINAL_RESULTS_MMPBSA.dat -sp ../step3_pbcsetup.prmtop -cp complex.prmtop -rp protein.prmtop -lp ligand.prmtop -y ../step5.0*.dcd
