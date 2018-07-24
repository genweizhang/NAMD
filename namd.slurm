#!/bin/bash
#SBATCH --partition=gpu_kepler
#SBATCH --exclusive
#SBATCH --ntasks=20
#SBATCH --ntasks-per-node=20
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --time=48:00:00
#SBATCH --job-name=namd_ABT

date
JOBS="step5.03_production step5.04_production" 

[ -e namd.hostfile ] && rm namd.hostfile
echo "group main" >> namd.hostfile
for node in `scontrol show hostnames $SLURM_NODELIST | sort | uniq`
do
  echo "host ${node}" >> namd.hostfile
done


for i in $JOBS; do
    # Multicore
    # NAMD=$HOME/.local/opt/namd/2.12_Linux-multicore
    # $NAMD/namd2 +idlepoll +p${SLURM_NTASKS} +isomalloc_sync $i.inp > $i.out
    # ibverbs
    # NAMD=$HOME/.local/opt/namd/2.12_Linux-ibverbs
    # $NAMD/charmrun ++remote-shell ssh ++p ${SLURM_NTASKS} ++nodelist namd.hostfile $NAMD/namd2 +isomalloc_sync $i.inp > $i.out
    # GPU Multicore
    NAMD=/home/panxl/.local/opt/namd/2.12_Linux-multicore-CUDA
    $NAMD/namd2 +idlepoll +p${SLURM_NTASKS} +isomalloc_sync +devices 0,1 $i.inp > $i.out
    # GPU ibverbs
    # NAMD=$HOME/.local/opt/namd/2.12_Linux-ibverbs-smp-CUDA
    # $NAMD/charmrun ++remote-shell ssh ++p ${SLURM_NTASKS} ++nodelist namd.hostfile $NAMD/namd2 +idlepoll +devices 0,1  $i.inp > $i.out
done
date
